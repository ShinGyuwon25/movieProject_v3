package com.example.movieProject_v3.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Slf4j
@Service
public class TmdbService {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${tmdb.api.key}")
    private String apiKey;

    private final WebClient webClient = WebClient.builder()
            .baseUrl("https://api.themoviedb.org/3")
            .build();

    // 영화 검색
    public List<Map<String, Object>> searchMovies(String query) {
        try {
            String responseStr = webClient.get()
                    .uri(uriBuilder -> uriBuilder
                            .path("/search/movie")
                            .queryParam("api_key", apiKey)
                            .queryParam("query", query)
                            .queryParam("language", "ko-KR")
                            .queryParam("page", 1)
                            .build())
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();

            JsonNode response = objectMapper.readTree(responseStr);

            List<Map<String, Object>> results = new ArrayList<>();
            JsonNode movies = response.get("results");

            for (int i = 0; i < Math.min(movies.size(), 5); i++) {
                JsonNode movie = movies.get(i);
                Map<String, Object> movieInfo = new HashMap<>();

                // 영화 제목
                movieInfo.put("title", movie.path("title").asText(""));

                // 개봉연도
                String releaseDate = movie.path("release_date").asText("");
                String year = releaseDate.length() >= 4 ? releaseDate.substring(0, 4) : "";
                movieInfo.put("year", year);

                // 포스터 URL
                String posterPath = movie.path("poster_path").asText("");
                String posterUrl = posterPath.isEmpty() ? "" : "https://image.tmdb.org/t/p/w500" + posterPath;
                movieInfo.put("poster", posterUrl);

                // 장르, 국가는 상세 API로 따로 가져오기
                Integer movieId = movie.path("id").asInt();
                Map<String, String> details = getMovieDetails(movieId);
                movieInfo.put("genre", details.get("genre"));
                movieInfo.put("country", details.get("country"));

                results.add(movieInfo);
            }
            return results;

//        } catch (Exception e) {
//            log.error("TMDB 검색 실패", e);
//            return new ArrayList<>();
//        }

        } catch (Exception e) {
            log.error("TMDB 검색 실패: {}", e.getMessage(), e);
            return new ArrayList<>();
        }
    }

    // 영화 상세 정보 (장르, 국가)
    private Map<String, String> getMovieDetails(Integer movieId) {
        Map<String, String> details = new HashMap<>();
        details.put("genre", "");
        details.put("country", "");

        try {
            String responseStr = webClient.get()
                    .uri(uriBuilder -> uriBuilder
                            .path("/movie/" + movieId)
                            .queryParam("api_key", apiKey)
                            .queryParam("language", "ko-KR")
                            .build())
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();

            JsonNode response = objectMapper.readTree(responseStr);

            // 장르 (첫 번째 장르만)
            JsonNode genres = response.path("genres");
            if (genres.size() > 0) {
                details.put("genre", genres.get(0).path("name").asText(""));
            }

            // 국가 (첫 번째 제작 국가만)
            JsonNode countries = response.path("production_countries");
            if (countries.size() > 0) {
                String countryCode = countries.get(0).path("iso_3166_1").asText("");
                details.put("country", convertCountry(countryCode));
            }

        } catch (Exception e) {
            log.error("TMDB 상세 조회 실패", e);
        }
        return details;
    }

    // 국가 코드 → 한글 변환
    private String convertCountry(String code) {
        Map<String, String> countryMap = new HashMap<>();
        countryMap.put("KR", "한국");
        countryMap.put("US", "미국");
        countryMap.put("JP", "일본");
        countryMap.put("GB", "영국");
        countryMap.put("FR", "프랑스");
        countryMap.put("CN", "중국");
        countryMap.put("CA", "캐나다");
        countryMap.put("AU", "호주");
        countryMap.put("DE", "독일");
        countryMap.put("IT", "이탈리아");
        countryMap.put("ES", "스페인");
        countryMap.put("IN", "인도");
        countryMap.put("MX", "멕시코");
        countryMap.put("RU", "러시아");
        countryMap.put("TW", "대만");
        countryMap.put("HK", "홍콩");
        countryMap.put("NL", "네덜란드");
        countryMap.put("BR", "브라질");
        return countryMap.getOrDefault(code, code);
    }
}