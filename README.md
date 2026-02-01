# heg.wtf

HEG(Hyper Engineering Group) 공식 웹사이트입니다.

> Moving quickly, Staying small, Avoiding over-engineering.

## 소개

HEG의 프로젝트 포트폴리오와 회사 소개를 담은 정적 웹사이트입니다. GitHub Pages를 통해 배포됩니다.

**Live Site:** [https://heg.wtf](https://heg.wtf)

## 프로젝트 목록

### Active Projects
- **LocalMap - 동네지도**: 네이버 지도에 없는 진짜 동네 지도
- **드리븐**: 드라이브 코스 추천 서비스
- **Tools**: 생산성 향상을 위한 웹 도구 모음
- **약봉투**: AI 기반 약봉투 관리 앱
- **Word Defense**: 영어 단어 타이핑 게임
- **ZVC**: Python 개발자를 위한 정적 사이트 생성기
- **base**: 프리미엄 생산성 앱
- **마블노트**: 부루마블 게임 기록 앱
- **한우찾기**: 통합 한우 목장 관리 앱
- **공항주차**: 실시간 공항 주차 현황 앱
- **Alive**: 오늘도 살아있음을 확인하는 앱

### Deprecated Projects
- **1Pick**: AI 기반 맛집 추천 서비스

## 기술 스택

- **HTML5** - 시맨틱 마크업
- **CSS3** - 커스텀 속성, 애니메이션
- **GitHub Pages** - 정적 사이트 호스팅

## 프로젝트 구조

```
heg.wtf/
├── docs/               # GitHub Pages 배포 디렉토리
│   ├── index.html      # 메인 랜딩 페이지
│   ├── style.css       # 스타일시트
│   ├── CNAME           # 커스텀 도메인 설정
│   └── *.png           # 프로젝트 로고 이미지
├── raw/                # 원본 리소스 파일
└── README.md           # 이 파일
```

## 로컬 개발

로컬에서 사이트를 미리보려면:

```bash
cd docs
python3 -m http.server 8000
```

브라우저에서 `http://localhost:8000` 접속

## 배포

`main` 브랜치에 푸시하면 GitHub Pages를 통해 자동 배포됩니다.

## 라이선스

© 2025 HEG. All rights reserved.
