# Docker로 실습 환경 실행하기

이 Docker 이미지는 Quarto 1.6.42, R 4.4.2, XeLaTeX, 실습용 R 패키지, D2Coding 글꼴과 Codex CLI를 제공합니다. 데모는 외부 데이터 없이 실행됩니다. `data/` 폴더는 배포하지 않습니다.

## 이미지 만들기

프로젝트 루트 폴더에서 실행합니다.

```bash
docker build --platform linux/amd64 -t nhis-report-workshop:1.0 ./docker
```

## PDF 만들기

macOS 또는 Linux에서는 실습 폴더에서 다음 명령을 실행합니다.

```bash
docker run --rm --platform linux/amd64 \
  --user "$(id -u):$(id -g)" -e HOME=/tmp \
  -v "$(pwd):/workspace" \
  -w /workspace nhis-report-workshop:1.0 \
  quarto render demo.qmd --to pdf
```

결과 PDF는 `_output/`에 저장됩니다.

## VS Code Dev Container

1. VS Code에서 프로젝트 루트 폴더를 엽니다.
2. **Dev Containers** 확장을 설치합니다.
3. 명령 팔레트에서 **Dev Containers: Reopen in Container**를 실행합니다.
4. Codex 확장(`openai.chatgpt`)은 컨테이너를 열 때 자동 설치됩니다. 처음 사용할 때 로그인합니다.
5. 컨테이너 터미널에서 `quarto render demo.qmd --to pdf` 또는 `codex`를 실행합니다.

## Windows PowerShell

```powershell
docker build --platform linux/amd64 -t nhis-report-workshop:1.0 .\docker
$workshop = (Get-Location).Path
docker run --rm --platform linux/amd64 --mount "type=bind,source=$workshop,target=/workspace" -w /workspace nhis-report-workshop:1.0 quarto render demo.qmd --to pdf
```

## 글꼴 출처

D2Coding은 NAVER의 SIL Open Font License 글꼴입니다. Docker 이미지 생성 시 공식 저장소의 1.3.3 태그에서 글꼴과 라이선스를 받습니다. Pretendard도 공식 1.3.9 릴리스에서 받아 설치하며, 라이선스 사본은 `assets/fonts/LICENSE.txt`에 포함되어 있습니다.
