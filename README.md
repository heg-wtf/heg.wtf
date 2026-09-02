# heg.wtf

HEG(Hyper Engineering Group) 공식 웹사이트입니다.

> Moving quickly, Staying small, Avoiding over-engineering.

## 소개

HEG의 프로젝트 포트폴리오와 회사 소개를 담은 정적 웹사이트입니다. GitHub Pages(`docs/`)로 배포됩니다.

**Live Site:** [https://heg.wtf](https://heg.wtf)
**Build log:** [https://bit.heg.wtf](https://bit.heg.wtf) (#buildinpublic)

## 디자인

- 벤토 그리드 레이아웃. 최신 프로젝트(CreatureX)를 2×2 피처 타일로, 나머지 제품·통계·링크를 타일로 배치
- 컬러 토큰은 Tailwind gray 계열 + 블루 `#3b82f6`. `prefers-color-scheme`로 라이트/다크 자동 전환
- 타이포그래피: [Outfit](https://fonts.google.com/specimen/Outfit) (Google Fonts), 한국어는 시스템 산세리프 폴백
- 모션: 타일 hover 스케일·리프트, 뷰포트 밖 타일 스크롤 reveal. `prefers-reduced-motion` 시 비활성

## 프로젝트 목록

### Active Projects
- **CreatureX**: 사진으로 생물을 식별하고 수집하는 도감 앱
- **제주공항주차**: 제주국제공항 P1/P2 실시간 주차 현황 앱
- **드리븐**: 드라이브 코스 추천 서비스
- **LocalMap - 동네지도**: 네이버 지도에 없는 진짜 동네 지도
- **Alive**: 오늘도 살아있음을 확인하는 앱
- **약봉투**: AI 기반 약봉투 관리 앱
- **Word Defense**: 영어 단어 타이핑 게임
- **base**: 프리미엄 생산성 앱
- **마블노트**: 부루마블 게임 기록 앱
- **한우찾기**: 통합 한우 목장 관리 앱
- **공항주차**: 실시간 공항 주차 현황 앱
- **Tools**: 생산성 향상을 위한 웹 도구 모음
- **Simple Racing Game**: 이스탄불 파크 서킷 3D 레이싱 게임

### Open Source
- **ZVC**: Python 개발자를 위한 정적 사이트 생성기

### Deprecated Projects
- **1Pick**: AI 기반 맛집 추천 서비스

## 개발

```bash
make help     # 타겟 목록
make format   # prettier(index.html) + ruff format(scripts, tests)
make lint     # format → ruff check → 빌드 산출물 검증(로컬 자산·앵커·필수 meta)
make test     # scripts/check_site.py 단위 테스트
make server   # http://localhost:8000 로컬 서빙
```

`make lint`는 `scripts/check_site.py`로 `docs/` 아래 모든 HTML의 로컬 참조(이미지·CSS·링크), 페이지 내 앵커, 필수 meta를 검사합니다. 외부 의존성은 `uvx`(ruff)와 `npx`(prettier)만 사용합니다.

## 기술 스택

- **HTML5 / CSS3** - 단일 파일, CSS 커스텀 속성 토큰, 인라인 스타일
- **Google Fonts** - Outfit
- **GitHub Pages** - 정적 사이트 호스팅

## 프로젝트 구조

```
heg.wtf/
├── docs/                          # GitHub Pages 배포 디렉토리
│   ├── index.html                 # 메인 랜딩 페이지 (벤토)
│   ├── privacy-policy.html        # 개인정보 처리방침
│   ├── child-safety-standards.html
│   ├── CNAME                      # 커스텀 도메인 설정
│   ├── app-ads.txt
│   └── *.png, *.jpg               # 프로젝트 아이콘 (224px), logo.png (OG 이미지)
├── plans/                         # 작업 계획 문서
├── scripts/check_site.py          # 정적 사이트 검증 스크립트
├── tests/                         # 검증 스크립트 단위 테스트
├── raw/                           # 원본 리소스 파일
├── Makefile
└── README.md
```
