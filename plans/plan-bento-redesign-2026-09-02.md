# Plan: heg.wtf · bit 벤토 리디자인
- date: 2026-09-02
- status: done
- author: claude
- approved-by: ash84 (시안 H 승인, 2026-09-02)

## 1. 목적 및 배경
- 현재 heg.wtf 홈은 14개 프로젝트 카드가 동일 구조로 나열되어 시각 위계가 없고, 모션이 fade-in 하나로 "hype"가 부족하다.
- 시안 8종(`claude.ai/code/artifact/90ca00a3-…`) 중 **H · Bento (현재 팔레트)** 확정. 레이아웃(벤토 그리드)이 임팩트를 담당하고 컬러는 기존 Tailwind gray + 블루 `#3b82f6`를 유지해 privacy/child-safety 페이지와 일관성을 지킨다.
- heg.wtf에서 `#buildinpublic`으로 링크되는 `bit.heg.wtf`(../bit)도 같은 컨셉으로 맞춘다.
- 부수 문제: 84px 아이콘에 1024px 원본(최대 1.3MB)을 쓰고 있어 총 전송량 6MB+. 미참조 `style.css`, `*.backup` 잔여물.

## 2. 예상 임팩트
- **heg.wtf**: `docs/index.html` 전면 교체(구조·스타일·스크립트). 프로젝트 아이콘 PNG/JPG 224px로 재인코딩. privacy/child-safety 페이지는 `privacy-policy.html` meta description 1줄 추가 외 변경 없음.
- **bit**: `themes/bit/index.html`, `themes/bit/post.html`, `themes/bit/assets/style.css` 교체 → `make build` 산출물 `docs/` 전체 재생성. 콘텐츠(`contents/`)와 자동 포스트 파이프라인(`scripts/`)은 변경 없음.
- 성능: heg.wtf 이미지 전송량 약 6MB → 0.5MB 이하. Google Fonts(Outfit) 1개 추가 요청(preconnect).
- UX: 홈 정보 구조 변경(카드 리스트 → 벤토). bit 홈은 전문 인라인 → 요약 카드 + 개별 페이지. 다크모드는 두 사이트 모두 `prefers-color-scheme` 유지.
- SEO: URL 변경 없음. bit 개별 페이지 canonical/og:url 오류(`/{pub_date}/{slug}/` → 실제 경로 `/YYYY/MM/DD/slug/`) 수정.

## 3. 구현 방법 비교
| 방법 | 장점 | 단점 |
|---|---|---|
| A. 단일 HTML 인라인 CSS 유지(현행 구조) | 빌드 도구 없음, GitHub Pages 그대로, 배포 단순 | CSS 재사용 불가(privacy 페이지와 별도) |
| B. 공통 `style.css` 분리 + 각 페이지 링크 | 페이지 간 토큰 공유 | privacy/child-safety도 손대야 하고 이번 범위 초과 |
| C. zvc 등 SSG 도입 | 템플릿화 | 정적 1페이지에 과도한 엔지니어링 |

**선택: A.** 이번 범위는 홈 1페이지. 토큰은 `:root` 변수로 정의해 이후 B로 옮기기 쉽게 둔다. bit는 이미 zvc 템플릿 구조이므로 템플릿·CSS만 교체한다.

## 4. 구현 단계
### heg.wtf
- [x] Step 1: 브랜치 `feat/bento-redesign`, plan 문서 작성
- [x] Step 2: 프로젝트 아이콘 224px 재인코딩(`sips`), `*.backup`·미참조 `docs/style.css` 삭제 (`logo.png`는 OG 이미지라 유지)
- [x] Step 3: `docs/index.html` 재작성 — 토큰(라이트/다크), Outfit, nav, hero, 벤토(13 제품 + 통계 + 링크 타일), Open Source, Mission, Retired, footer, reveal/hover 모션, reduced-motion
- [x] Step 4: `Makefile`(help/format/lint/test/server) + `scripts/check_site.py`(자산 참조·앵커·필수 meta 검증) + `tests/`. 검증에서 드러난 `privacy-policy.html` meta description 누락 1건 보완
- [x] Step 5: 헤드리스 Chrome으로 라이트/다크/모바일 렌더 확인
- [x] Step 6: README 갱신, 커밋, PR

### bit
- [x] Step 7: 브랜치 `feat/bento-redesign`
- [x] Step 8: `themes/bit/assets/style.css` 재작성 — heg.wtf와 동일 토큰, Outfit + Bitcount 워드마크, 한국어 본문 타이포
- [x] Step 9: `themes/bit/index.html` — nav(heg.wtf 링크), 통계 타일(글 수·첫 글·최근 글), 글 카드 그리드(최신 글 feature), JSON-LD URL을 `post.link`로 수정
- [x] Step 10: `themes/bit/post.html` — 동일 nav, 본문 타이포, 태그, 자산 경로 절대화(`/assets/…`), canonical/og:url 수정
- [x] Step 11: `Makefile` 규칙 반영(.PHONY/help/lint/test) + `scripts/check_site.py` + `tests/`
- [x] Step 12: `make build` → `docs/` 재생성, 헤드리스 Chrome 확인, CLAUDE.md 갱신, 커밋, PR

## 5. 테스트 계획
**단위 테스트 (`scripts/check_site.py`):**
- [x] 로컬 자산 참조(`src`, `href`)가 실제 파일로 존재하면 통과, 없으면 실패
- [x] `#anchor` 링크가 문서 내 id로 존재하면 통과, 없으면 실패
- [x] 필수 meta(`description`, `og:image`, `viewport`) 누락 시 실패
- [x] 외부 URL(`http`, `mailto`)은 검사 대상에서 제외

**통합 테스트:**
- [x] heg.wtf: `make lint && make test` 통과, 헤드리스 렌더에서 라이트/다크 모두 텍스트 대비 정상, 375px에서 가로 스크롤 없음
- [x] bit: `make build` 성공, `docs/index.html` 카드 수 = `contents/` 글 수(39), 개별 페이지에서 `/assets/style.css` 로드, `make lint` 통과
- [x] 두 사이트 모두 `#buildinpublic` ↔ `heg.wtf` 상호 링크 정상

## 6. 사이드 이펙트
- **아이콘 해상도 축소**: 다른 사이트가 `https://heg.wtf/<icon>.png`를 핫링크했다면 224px로 보임. `logo.png`(OG)는 원본 유지 → 대응 완료
- **`docs/style.css` 삭제**: 어떤 HTML도 참조하지 않음(grep 확인) → 해당 없음
- **bit 홈 전문 인라인 제거**: 홈 크롤 시 본문이 요약만 노출. 개별 페이지가 이미 생성·색인 가능하고 JSON-LD가 개별 URL을 가리키므로 SEO 영향 제한적 → 대응 완료
- **bit 자동 포스트 파이프라인**: `make build` 인터페이스 유지, `scripts/auto-post.sh` 미변경 → 해당 없음
- **bit 콘텐츠 수정**: 250815·260302 두 글의 `<img src>`가 예전 인라인 홈에서만 풀리던 상대경로였음. 절대경로로 수정(본문 텍스트 불변) → 대응 완료
- 하위 호환: URL 변경 없음. 마이그레이션 없음.

## 결과
- heg.wtf: https://github.com/heg-wtf/heg.wtf/pull/5
- bit: https://github.com/heg-wtf/bit/pull/2

## 7. 보안 검토
- OWASP Top 10: 정적 HTML, 사용자 입력 없음, 서버 코드 없음 → 해당 없음
- 인증/인가 변경: 없음
- 민감 데이터: 없음 (기존 GA ID, AdSense 계정 meta는 이미 공개 값)
- PCI-DSS: 해당 없음
- 외부 스크립트: 기존 GA 유지. 신규 외부 리소스는 Google Fonts CSS만 추가
