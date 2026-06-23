-- 테이블 생성 --

CREATE TABLE `myboard` (
  `seq` int NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `poster` varchar(100) DEFAULT NULL,
  `mcountry` varchar(30) DEFAULT NULL,
  `mgenre` varchar(30) DEFAULT NULL,
  `mtitle` varchar(100) DEFAULT NULL,
  `myear` int DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `score` float DEFAULT NULL,
  `time` datetime(6) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `views` int DEFAULT '0',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mycomment` (
  `seq` int NOT NULL AUTO_INCREMENT,
  `board_seq` int DEFAULT NULL,
  `content` text NOT NULL,
  `name` varchar(30) NOT NULL,
  `time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mymember` (
  `seq` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) DEFAULT NULL,
  `id` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `pass` varchar(30) NOT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `UKt4bmqgnnsl9dptu69rkdf27y6` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 데이터 삽입 --

INSERT INTO movie_db.myboard
(seq, content, poster, mcountry, mgenre, mtitle, myear, name, score, `time`, title, views)
VALUES(5, '꿈과 현실 사이에서 방황하는 청춘들의 모습이 너무 아름답고도 아프게 다가왔습니다.
<br>특히 마지막 10분, ''만약 그랬다면 어땠을까'' 하는 상상 씬에서는 눈물을 멈출 수가 없었네요.
<br>화려한 영상미와 OST는 말할 것도 없고, 며칠 동안 여운이 길게 남는 제 인생 최고의 음악 영화입니다!', '_________08c.jpg', '미국', '뮤지컬', '라라랜드', 2016, '왕호박', 5.0, '2026-06-18 18:00:20.327000', '라라랜드 후기', 10);
INSERT INTO movie_db.myboard
(seq, content, poster, mcountry, mgenre, mtitle, myear, name, score, `time`, title, views)
VALUES(6, '- 타이타닉 줄거리 -
<br>이 세상 마지막 순간까지 같이하는 사랑
<br>“내 인생의 가장 큰 행운은 도박에서 딴 티켓으로 당신을 만난 거야”
<br>단 하나의 운명, 단 한 번의 사랑, 영원으로 기억될 세기의 러브 스토리
<br>
<br>- 나의 후기 -
<br>몇 번을 다시 봐도 볼 때마다 가슴이 먹먹해지는 제 마음속 부동의 1위 인생 영화입니다.
<br>거대한 재난 속에서 피어난 잭과 로즈의 비극적이면서도 위대한 사랑 이야기는 매번 전율을 돋게 하네요.
<br>후반부 침몰 씬의 압도적인 스케일과 배우들의 명연기, 그리고 심장을 울리는 OST까지 모든 박자가 완벽합니다.
<br>단순한 로맨스를 넘어 인간의 삶과 죽음, 사랑의 가치를 증명해 주는 시대를 초월한 최고의 명작입니다!', 'Titanic7f2.png', '미국', '로맨스', '타이타닉', 1997, '홍길동', 5.0, '2026-06-18 18:07:56.666000', '타이타닉은 내 인생영화!', 15);
INSERT INTO movie_db.myboard
(seq, content, poster, mcountry, mgenre, mtitle, myear, name, score, `time`, title, views)
VALUES(7, '톰크루즈의 수많은 명작 중에서도 단연 최고의 필모그래피로 꼽고 싶은 제 인생 SF 영화입니다.
<br>범죄를 예측해 미리 체포한다는 독창적인 소재와 시종일관 긴장감을 놓을 수 없는 톰 크루즈의 압도적인 추격 액션이 압권이네요.
<br>2002년작이라는 게 믿기지 않을 만큼 세련된 미장센과 미래 세계관 연출은 지금 봐도 소름 돋을 정도로 완벽합니다.
<br>단순한 오락 영화를 넘어 인간의 자유 의지와 운명에 대한 묵직한 메시지까지 던져주는 완벽한 마스터피스입니다!', 'MinorityReport653.png', '미국', 'SF', '마이너리티 리포트', 2002, '김사과', 4.0, '2026-06-18 18:11:37.036000', '톰크루즈하면 이 영화', 18);
INSERT INTO movie_db.myboard
(seq, content, poster, mcountry, mgenre, mtitle, myear, name, score, `time`, title, views)
VALUES(8, '어릴 때 비디오로 숨 죽여 보던 기억이 나서 오랜만에 다시 정주행했는데, 여전히 명작은 명작이네요.
지금 봐도 그래픽이나 연출이 전혀 이질감 없고 재밌긴 한데, 확실히 어릴 때 밤새 잠 못 자며 느꼈던 그 압도적인 공포와 전율만큼은 안 나서 살짝 아쉽기도 합니다.
그때는 티라노사우루스가 화면을 뚫고 나올 것처럼 무서웠는데, 지금은 추억에 젖어 마음 편하게 감상하게 되네요.
그래도 제 유년 시절의 환상과 동심을 완벽하게 채워줬던, 언제 봐도 가슴 뛰는 최고의 인생 영화입니다!', 'JurassicPark56d.png', '미국', '스릴러', '쥬라기 공원', 1993, '고구마', 4.0, '2026-06-18 18:15:02.386000', '오랜만에 다시봤어요', 11);
INSERT INTO movie_db.myboard
(seq, content, poster, mcountry, mgenre, mtitle, myear, name, score, `time`, title, views)
VALUES(9, '제 한줄평은 ''배우들의 명연기가 살린, 하지만 후반부 배분이 아쉬운 웰메이드 사극''
<br>
<br>수양대군의 압도적인 등장 씬과 백윤식, 송강호 등 명배우들의 불꽃 튀는 연기 대결만으로도 티켓값은 충분히 하는 영화입니다.
<br>관상이라는 흥미로운 소재를 역사적 비극인 계유정난과 매끄럽게 엮어낸 초중반부의 몰입감은 상당한 편이네요.
<br>다만 후반부로 갈 수록 파국으로 치닫는 역사의 무게감에 짓눌려 초반의 신선했던 ''관상''이라는 소재의 매력이 흐릿해지는 점은 다소 아쉽습니다.
<br>연출과 연기의 힘으로 단점을 덮었지만, 스토리의 완급 조절 면에서는 진한 여운보다는 기운이 조금 빠지는 평작과 명작 사이의 별점 3점짜리 작품입니다.', '______554.png', '한국', '드라마', '관상', 2013, '영화광', 3.0, '2026-06-18 18:23:47.224000', '관상 봤는데...', 11);
INSERT INTO movie_db.myboard
(seq, content, poster, mcountry, mgenre, mtitle, myear, name, score, `time`, title, views)
VALUES(10, '오랜만에 스토리 본연의 재미에 푹 빠져서 감상한 최고의 추리 영화입니다.
<br>대저택에서 벌어진 살인 사건과 개성 넘치는 용의자들의 거짓말을 하나씩 파헤쳐 가는 과정이 정말 흥미진진하네요.
<br>무거운 스릴러라기보다는 유쾌하고 재치 있는 연출이 많아서 남녀노소 누구나 가볍고 재미있게 즐길 수 있는 작품인 것 같습니다.
<br>마지막 순간까지 몰입감을 잃지 않는 웰메이드 반전 영화를 찾으신다면 꼭 한 번 보시기를 추천해 드립니다.', 'KnivesOutef8.png', '미국', '코미디', '나이브스 아웃', 2019, '무비무비', 5.0, '2026-06-18 18:28:41.730000', '추리물 좋아하면 추천입니다', 6);
INSERT INTO movie_db.myboard
(seq, content, poster, mcountry, mgenre, mtitle, myear, name, score, `time`, title, views)
VALUES(11, '개성 넘치는 캐릭터들이 서로 속고 속이는 과정이 잠시도 지루할 틈 없이 스피디하게 전개됩니다.
<br>홍콩과 마카오를 배경으로 펼쳐지는 짜릿한 와이어 액션과 배우들의 찰진 대사 주거니 받거니를 보는 것만으로도 러닝타임이 훌쩍 지나가네요.
<br>마냥 가볍지만은 않은 반전과 로맨스 라인까지 적절히 섞여 있어 대중적으로 누구나 호불호 없이 즐길 수 있는 웰메이드 상업 영화라고 생각합니다.
<br>한국 오락 영화 중에서 짜임새와 재미를 모두 잡은 몇 안 되는 수작으로, 킬링타임용으로 강력 추천합니다.', '________27d.png', '한국', '범죄', '도둑들', 2012, '무비무비', 5.0, '2026-06-18 18:31:32.501000', '최고의 오락 영화', 2);

INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(2, 5, '저도 이 영화 엄청 좋아합니다!', '홍길동', '2026-06-18 18:05:08.349000');
INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(3, 5, '오 재밌나요? 이번 주말 영화는 이걸로', '김사과', '2026-06-18 18:09:18.757000');
INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(4, 6, '저 이 영화보고 울었어요 ㅋㅋ', '김사과', '2026-06-18 18:09:34.975000');
INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(6, 7, '저도 톰크루즈 팬이에요', '고구마', '2026-06-18 18:12:57.729000');
INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(8, 6, '재밌죠 이 영화!!', '고구마', '2026-06-18 18:15:44.691000');
INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(9, 8, '오 추억의 영화 ㅎㅎ', '영화광', '2026-06-18 18:24:09.728000');
INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(10, 9, '저는 재밌게 봤는데 아쉬운점도 이해가 가네요~', '무비무비', '2026-06-18 18:25:30.829000');
INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(11, 7, '재밌게봤어요~', '무비무비', '2026-06-18 18:25:55.608000');
INSERT INTO movie_db.mycomment
(seq, board_seq, content, name, `time`)
VALUES(12, 9, '저랑 똑같이 생각하시네요!!', '무비무비', '2026-06-18 18:29:41.662000');


INSERT INTO movie_db.mymember
(seq, email, id, name, pass)
VALUES(1, 'testid@naver.com', 'testid', '테스트', 'OK1234');
INSERT INTO movie_db.mymember
(seq, email, id, name, pass)
VALUES(2, 'ok1234@naver.com', 'ok1234', '왕호박', 'OK1234');
INSERT INTO movie_db.mymember
(seq, email, id, name, pass)
VALUES(3, 'hong123@gmail.com', 'hong123', '홍길동', 'OK1234');
INSERT INTO movie_db.mymember
(seq, email, id, name, pass)
VALUES(4, 'appleking01@kakao.com', 'apple01', '김사과', 'OK1234');
INSERT INTO movie_db.mymember
(seq, email, id, name, pass)
VALUES(5, 'hoho012@naver.com', 'hoho012', '고구마', 'OK1234');
INSERT INTO movie_db.mymember
(seq, email, id, name, pass)
VALUES(6, 'kk7777@daum.net', 'kk7777', '영화광', 'OKOK12');
INSERT INTO movie_db.mymember
(seq, email, id, name, pass)
VALUES(7, 'ohlove@nate.com', 'ohohlove', '무비무비', 'OK1234');