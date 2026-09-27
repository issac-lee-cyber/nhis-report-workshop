# Build from the docker/ directory. The image contains tools, not workshop files.
FROM rocker/verse:4.4.2

ARG QUARTO_VERSION=1.6.42
ARG CODEX_VERSION=latest
ARG PRETENDARD_VERSION=1.3.9
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=Asia/Seoul

RUN /rocker_scripts/install_quarto.sh "${QUARTO_VERSION}" \
    && install2.r --error --skipinstalled ggplot2 knitr ragg systemfonts

# Codex CLI is available in the image, including outside VS Code.
RUN apt-get update \
    && apt-get install -y --no-install-recommends npm unzip \
    && npm install -g "@openai/codex@${CODEX_VERSION}" \
    && codex --version \
    && rm -rf /var/lib/apt/lists/*

RUN tlmgr install cjk-ko fontspec fancyhdr tcolorbox booktabs float pgf
RUN tlmgr install xetexko
RUN tlmgr install pdfcol unicode-math caption

RUN mkdir -p /usr/local/share/fonts/d2coding /usr/local/share/doc/d2coding \
    && wget -q https://raw.githubusercontent.com/naver/d2-coding-font/VER1.3.3/fonts/ttf/D2Coding-Regular.ttf \
      -O /usr/local/share/fonts/d2coding/D2Coding-Regular.ttf \
    && wget -q https://raw.githubusercontent.com/naver/d2-coding-font/VER1.3.3/OFL.txt \
      -O /usr/local/share/doc/d2coding/OFL.txt \
    && test -s /usr/local/share/fonts/d2coding/D2Coding-Regular.ttf \
    && test -s /usr/local/share/doc/d2coding/OFL.txt \
    && fc-cache -f \
    && fc-match D2Coding | grep -q 'D2Coding-Regular.ttf' \
    && quarto --version \
    && Rscript -e 'stopifnot(all(vapply(c("ggplot2", "knitr", "ragg", "systemfonts"), requireNamespace, logical(1), quietly=TRUE)))' \
    && rm -rf /tmp/downloaded_packages

RUN mkdir -p /usr/local/share/fonts/pretendard \
    && wget -q "https://github.com/orioncactus/pretendard/releases/download/v${PRETENDARD_VERSION}/Pretendard-${PRETENDARD_VERSION}.zip" -O /tmp/pretendard.zip \
    && unzip -j /tmp/pretendard.zip "public/static/Pretendard-Regular.otf" "public/static/Pretendard-Medium.otf" "public/static/Pretendard-Bold.otf" "public/static/Pretendard-ExtraBold.otf" -d /usr/local/share/fonts/pretendard \
    && wget -q "https://raw.githubusercontent.com/orioncactus/pretendard/v${PRETENDARD_VERSION}/LICENSE" -O /usr/local/share/doc/pretendard-OFL.txt \
    && fc-cache -f \
    && fc-match Pretendard | grep -q Pretendard \
    && rm -f /tmp/pretendard.zip

WORKDIR /work
CMD ["bash"]
