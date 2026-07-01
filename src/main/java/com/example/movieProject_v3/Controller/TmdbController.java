package com.example.movieProject_v3.Controller;

import com.example.movieProject_v3.service.TmdbService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class TmdbController {

    private final TmdbService tmdbService;

    // 영화 검색 (Ajax용)
    @RequestMapping(value = "/searchMovie.do")
    @ResponseBody
    public List<Map<String, Object>> searchMovie(@RequestParam String query) {
        return tmdbService.searchMovies(query);
    }
}