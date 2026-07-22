# 🎬 CineLog - 영화 리뷰 커뮤니티

> 영화를 사랑하는 사람들이 리뷰를 공유하는 커뮤니티 플랫폼

<br>

## 📌 프로젝트 소개

CineLog는 학부 과제로 시작한 영화 리뷰 게시판 프로젝트를 QA 관점에서 분석하고 개선한 포트폴리오입니다.  
구 버전에서 발견한 보안 취약점, 설계 문제, UX 불편함을 직접 문서화하고 신 버전에서 개선했습니다.

<br>

## 🛠 기술 스택

| 분류 | 기술 |
|------|------|
| Backend | Java 21, Spring Boot 4.0.6, Spring Security |
| ORM | Spring Data JPA, Hibernate |
| Database | MySQL 8.0 |
| Frontend | JSP, Bootstrap, JavaScript |
| External API | TMDB API |
| Build | Gradle |
| IDE | IntelliJ IDEA |

<br>

## ✨ 주요 기능

### 🎬 게시글
- TMDB API 연동으로 영화 검색 시 영화 정보 자동 입력
- 별점 및 영화 리뷰 함께 작성
- 영화별 평균 별점 집계 표시
- 인기 리뷰 TOP 3 메인 화면 노출

### 👥 회원
- BCrypt 비밀번호 암호화
- 프로필 사진 업로드
- 마이페이지 (내 글/댓글/좋아요 관리)

### 💬 커뮤니티
- 댓글 및 답글 기능
- 글 좋아요 
- 최신순/인기순/별점순 정렬
- 장르/국가 필터링 검색

<br>

## 🔧 구 버전 대비 주요 개선사항

| 분류 | 개선 내용 |
|------|-----------|
| 🔴 보안 | 비밀번호 BCrypt 암호화 |
| 🔴 보안 | DB 계정 환경변수 분리 |
| 🔴 보안 | 권한 체크 이름 → seq(고유번호)로 변경 |
| 🔴 보안 | 파일 업로드 타입 검증 추가 |
| 🟡 구조 | Service Layer 분리 (Controller → Service → Repository) |
| 🟡 구조 | 생성자 인젝션으로 변경 |
| 🟡 구조 | 로거 적용 (e.printStackTrace → @Slf4j) |
| 🟢 기능 | TMDB API 영화 정보 자동완성 |
| 🟢 기능 | 좋아요, 댓글 답글, 마이페이지 추가 |
| 🟢 UX | 실시간 입력값 유효성 검사 |
| 🟢 UX | 다크 시네마 테마 UI 전면 개편 |

<br>

## ▶ 실행 방법

### 사전 준비
- Java 21
- MySQL 8.0
- Gradle

### 환경 변수 설정
IntelliJ 실행 구성 → 환경 변수에 아래 추가:
```
DB_USERNAME=your_db_username
DB_PASSWORD=your_db_password
```

### DB 설정
```sql
CREATE DATABASE movie_db;
```

### 실행
```bash
git clone https://github.com/ShinGyuwon25/movieProject_v3.git
cd movieProject_v3
./gradlew bootRun
```

접속: `http://localhost:8080/boardList.do`

<br>

## 📁 프로젝트 구조
``` 
src/main/java/com/example/movieProject_v3/
├── Controller/ # 요청/응답 처리 
├── service/ # 비즈니스 로직 
├── repository/ # DB 접근 
└── entity/ # JPA 엔티티 
```


<br>

## 🔗 관련 레포지토리

- 원본 (sts버전): [movieProject](https://github.com/ShinGyuwon25/movieProject)
- 구 버전(1): [movieProject_v1](https://github.com/ShinGyuwon25/movieProject_v1)
- 구 버전(2): [movieProject_v2](https://github.com/ShinGyuwon25/movieProject_v2)

