# Quarto 보고서 데모 환경

QMD 파일을 편집하고 한글 PDF로 렌더링하는 최소 실습 환경입니다. 데이터 파일은 배포하지 않으며, `demo.qmd`는 외부 데이터 없이 실행됩니다.

## 파일 구성

- `demo.qmd`: 편집을 시작할 데모 문서
- `_quarto.yml`: PDF 출력 설정
- `nhisbook.cls`: PDF 서식
- `assets/fonts/`: Pretendard 글꼴과 라이선스
- `assets/top_logo.pdf`, `assets/keyboard.pdf`: 서식에서 사용하는 이미지
- `.devcontainer/`: VS Code 컨테이너 설정
- `docker/`: 실행 환경의 Dockerfile과 실행 안내

## 시작하기

Docker와 VS Code의 Dev Containers 확장을 설치한 뒤 이 폴더를 VS Code에서 엽니다. 명령 팔레트에서 **Dev Containers: Reopen in Container**를 실행하면 실행 환경을 빌드합니다.

컨테이너 터미널에서 다음 명령으로 데모 PDF를 만듭니다.

```bash
quarto render demo.qmd --to pdf
```

결과는 `_output/demo.pdf`에 저장됩니다. `demo.qmd`를 수정하고 같은 명령을 다시 실행하면 됩니다.

VS Code 없이 Docker로 실행하는 방법은 [Docker 안내](docker/README.md)를 참고하세요.

## 공개 범위

`data/`, 렌더링 결과, 캐시와 로그는 Git에서 제외합니다. 개인별 데이터가 필요하면 로컬 `data/` 폴더에 별도로 준비합니다.
