\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nhisbook}[2026/09/24 NHIS Quarto Book class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax
\LoadClass[a4paper,11pt,oneside,open=any]{scrbook}

\RequirePackage{iftex}
\ifXeTeX\else\ClassError{nhisbook}{XeLaTeX is required}{}\fi
\RequirePackage{fontspec}
\RequirePackage{kotex}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{tcolorbox}
\tcbuselibrary{skins,breakable}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{float}
\RequirePackage{tikz}
\usetikzlibrary{patterns}

\definecolor{NHISNavy}{HTML}{0C2340}
\definecolor{NHISTeal}{HTML}{189A9A}
\definecolor{NHISGold}{HTML}{DF973C}
\definecolor{NHISRed}{HTML}{D64B3C}
\definecolor{NHISGray}{HTML}{F1F5F9}
\definecolor{NHISInk}{HTML}{222222}
\IfFileExists{assets/fonts/Pretendard-ExtraBold.otf}{%
  \newfontfamily\NHISDisplayFont{Pretendard ExtraBold}%
}{%
  \newfontfamily\NHISDisplayFont{Pretendard-ExtraBold.otf}[Path=assets/fonts/]%
}

% Pandoc loads lmodern after the class; choose the bundled Korean fonts at document start.
\AtBeginDocument{%
  \IfFileExists{assets/fonts/Pretendard-Regular.otf}{%
    \setmainfont{Pretendard}[BoldFont=Pretendard Bold]%
    \setsansfont{Pretendard}[BoldFont=Pretendard Bold]%
  }{%
    \setmainfont{Pretendard-Regular.otf}[Path=assets/fonts/,BoldFont=Pretendard-Bold.otf]%
    \setsansfont{Pretendard-Regular.otf}[Path=assets/fonts/,BoldFont=Pretendard-Bold.otf]%
  }%
  \setmonofont{D2Coding}%
  \renewcommand{\contentsname}{목차}%
  \renewcommand{\figurename}{그림}%
  \renewcommand{\tablename}{표}%
  \renewcommand{\listfigurename}{그림 목차}%
  \renewcommand{\listtablename}{표 목차}%
}
\AddToHook{begindocument/end}{%
  \renewcommand{\figurename}{그림}%
  \renewcommand{\tablename}{표}%
}
\renewcommand{\maketitle}{}
\setkomafont{chapter}{\sffamily\bfseries\color{NHISNavy}\fontsize{16}{21}\selectfont}
\setkomafont{section}{\sffamily\bfseries\color{NHISTeal}\fontsize{15}{19.5}\selectfont}
\setkomafont{subsection}{\sffamily\bfseries\color{NHISNavy}\normalsize}
\setkomafont{part}{\sffamily\bfseries\Huge\ifnum\value{part}=1\color{NHISNavy}\else\color{NHISTeal}\fi}
\setkomafont{partnumber}{\sffamily\bfseries\Huge\ifnum\value{part}=1\color{NHISNavy}\else\color{NHISTeal}\fi}
\renewcommand*{\chaptermarkformat}{\thechapter 장\enskip}
\RedeclareSectionCommand[beforeskip=0pt,afterskip=10pt]{chapter}
\RedeclareSectionCommand[beforeskip=12pt,afterskip=7pt]{section}
\renewcommand*\normalsize{\@setfontsize\normalsize{11.5pt}{17.25pt}}
\AddToHook{begindocument/end}{\normalsize}
\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt}
\renewcommand{\arraystretch}{1.2}
\floatplacement{table}{H}
\raggedbottom

\pagestyle{empty}
\fancypagestyle{plain}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}
\AtBeginDocument{\pagestyle{empty}}

\newif\ifNHISPartPage
\newif\ifNHISBackCover
\newif\ifNHISChapterPage
\newif\ifNHISTabOnRight
\newcommand{\NHISChapterTitle}{}
\newcommand{\NHISChapterNumber}{}
\newcommand{\NHISCurrentPartTitle}{}
% Keep Quarto's ordinary numbered chapter and TOC entry, but reserve the top
% 60 mm for a vector chapter banner on its opening page.
\renewcommand*{\chapterlinesformat}[3]{%
  \IfBlankTF{#2}{#3}{%
    \global\NHISChapterPagetrue
    \gdef\NHISChapterTitle{#3}%
    \xdef\NHISChapterNumber{\thechapter}%
    \rule{0pt}{50mm}%
  }%
}
\newcommand{\NHISChapterBanner}{%
  \ifnum\value{part}=1
    % Part I: graphite opener, with its restrained red accent.
    \definecolor{NHISChapterPale}{HTML}{F2F1F0}%
    \definecolor{NHISChapterFade}{HTML}{E3E5E5}%
    \definecolor{NHISChapterAccent}{HTML}{282A2C}%
    \definecolor{NHISChapterFacet}{HTML}{D64B3C}%
    \definecolor{NHISChapterEdge}{HTML}{D0D2D2}%
  \else
    % Part II: the same teal used by its full-page opener.
    \definecolor{NHISChapterPale}{HTML}{EBF8F7}%
    \definecolor{NHISChapterFade}{HTML}{D7EFF0}%
    \definecolor{NHISChapterAccent}{HTML}{168F95}%
    \definecolor{NHISChapterFacet}{HTML}{168F95}%
    \definecolor{NHISChapterEdge}{HTML}{B5DCDE}%
  \fi
  \begin{tikzpicture}[remember picture,overlay]
    \begin{scope}[shift={(current page.north west)},x=1mm,y=1mm]
      \begin{scope}
        \clip (0,0) -- (210,0) -- (210,-39)
          .. controls (210,-52) and (197,-60) .. (185,-60)
          -- (0,-60) -- cycle;
        \shade[left color=NHISChapterPale,right color=NHISChapterFade]
          (0,0) rectangle (210,-60);
        \fill[NHISChapterFacet,opacity=.035]
          (0,0) -- (82,0) -- (0,-60) -- cycle;
        \fill[NHISChapterFacet,opacity=.025]
          (210,0) -- (152,0) -- (210,-48) -- cycle;
        \foreach \d in {-240,-232,...,240} {
          \draw[white,opacity=.48,line width=.23pt]
            (\d,0) -- ({\d+60},-60);
          \draw[white,opacity=.48,line width=.23pt]
            (\d,-60) -- ({\d+60},0);
        }
      \end{scope}
      \draw[NHISChapterEdge,line width=.45pt]
        (0,-60) -- (185,-60)
        .. controls (197,-60) and (210,-52) .. (210,-39);
      \fill[NHISChapterAccent] (105,-23) circle[radius=8mm];
      \ifnum\value{part}=1
        \draw[NHISRed,line width=.8pt] (105,-23) circle[radius=8mm];
      \fi
      \node[anchor=center,text=white,inner sep=0pt]
        at (105,-23)
        {{\NHISDisplayFont\fontsize{22}{25}\selectfont\NHISChapterNumber}};
      \node[anchor=center,text=NHISInk,text width=174mm,align=center,inner sep=0pt]
        at (105,-43)
        {{\NHISDisplayFont\fontsize{20}{24}\selectfont\NHISChapterTitle}};
    \end{scope}
  \end{tikzpicture}%
}
\AddToHook{shipout/background}{%
  \ifNHISChapterPage
    \NHISChapterBanner
    \global\NHISChapterPagefalse
  \fi
}
\newcommand{\NHISFolioNumber}{\ifnum\value{page}<10 0\fi\arabic{page}}
\newcommand{\NHISRightFolio}{%
  \node[anchor=south east,inner sep=0pt] at ([xshift=-6mm,yshift=5.3mm]current page.south east)
    {{\sffamily\fontsize{8.5}{10}\selectfont\color{gray}2026년도}\hspace{1mm}%
     {\sffamily\bfseries\fontsize{9.5}{11}\selectfont\color{NHISInk}AI 시대의 보고서 자동화 실무}%
     \hspace{1.8mm}{\color{gray}|}\hspace{1.8mm}%
     {\sffamily\bfseries\fontsize{10}{12}\selectfont\color{NHISInk}\NHISFolioNumber}};%
}
\newcommand{\NHISLeftFolio}{%
  \node[anchor=south west,inner sep=0pt] at ([xshift=6mm,yshift=5.3mm]current page.south west)
    {{\sffamily\bfseries\fontsize{10}{12}\selectfont\color{NHISInk}\NHISFolioNumber}%
     \hspace{1.8mm}{\color{gray}|}\hspace{1.8mm}%
     {\sffamily\bfseries\fontsize{9.5}{11}\selectfont\color{NHISInk}%
       \ifnum\value{page}=4 슬기로운 통계생활\else 국민건강보험\fi}%
     \hspace{1mm}{\sffamily\fontsize{8.5}{10}\selectfont
       \ifNHISPartPage\color{NHISNavy}\else\color{gray}\fi
       \ifnum\value{page}=4 AI 문서 자동화\else 보고서 자동화 실무\fi}};%
}
% One outside index rule for both part openers and body pages. The rule stops
% at the tab and resumes at its lower edge; each part occupies a 60 mm slot.
\newcommand{\NHISDrawOutsideIndex}{%
  \pgfmathsetlengthmacro{\NHISTabTop}{(\number\value{part}-1)*60mm}%
  \pgfmathsetlengthmacro{\NHISTabBottom}{\number\value{part}*60mm}%
  \pgfmathsetlengthmacro{\NHISTabMiddle}{(\number\value{part}-0.5)*60mm}%
  \ifnum\value{part}=1
    \definecolor{NHISTabColor}{HTML}{1A1A1A}%
  \else
    \definecolor{NHISTabColor}{HTML}{24A0AC}%
  \fi
  % Part openers keep the reference's right-side tab; ordinary pages mirror.
  \NHISTabOnRightfalse
  \ifNHISPartPage
    \NHISTabOnRighttrue
  \else
    \ifodd\value{page}\NHISTabOnRighttrue\fi
  \fi
  \ifNHISTabOnRight
    \draw[black,opacity=.25,line width=.25pt]
      ([xshift=-9.5mm]current page.north east) --
      ([xshift=-9.5mm,yshift=-\NHISTabTop]current page.north east);
    \draw[black,opacity=.25,line width=.25pt]
      ([xshift=-9.5mm,yshift=-\NHISTabBottom]current page.north east) --
      ([xshift=-9.5mm,yshift=8.6mm]current page.south east);
    \fill[NHISTabColor]
      ([xshift=-9.5mm,yshift=-\NHISTabTop]current page.north east)
      rectangle ([yshift=-\NHISTabBottom]current page.north east);
    \node[rotate=270,text=white,font=\sffamily\bfseries\scriptsize]
      at ([xshift=-4.75mm,yshift=-\NHISTabMiddle]current page.north east)
      {\Roman{part}. \NHISCurrentPartTitle};
  \else
    \draw[black,opacity=.25,line width=.25pt]
      ([xshift=9.5mm]current page.north west) --
      ([xshift=9.5mm,yshift=-\NHISTabTop]current page.north west);
    \draw[black,opacity=.25,line width=.25pt]
      ([xshift=9.5mm,yshift=-\NHISTabBottom]current page.north west) --
      ([xshift=9.5mm,yshift=8.6mm]current page.south west);
    \fill[NHISTabColor]
      ([yshift=-\NHISTabTop]current page.north west)
      rectangle ([xshift=9.5mm,yshift=-\NHISTabBottom]current page.north west);
    \node[rotate=270,text=white,font=\sffamily\bfseries\scriptsize]
      at ([xshift=4.75mm,yshift=-\NHISTabMiddle]current page.north west)
      {\Roman{part}. \NHISCurrentPartTitle};
  \fi
}
% Mirror the original A4 folio: odd at right, even at left, with an outside index tab.
\AddToHook{shipout/foreground}{%
  \ifnum\value{page}>1
  \ifNHISBackCover\else
    \begin{tikzpicture}[remember picture,overlay]
      \ifNHISPartPage\else
        \ifodd\value{page}
          \NHISRightFolio
        \else
          \ifnum\value{page}=2 \NHISRightFolio\else \NHISLeftFolio\fi
        \fi
      \fi
      \ifnum\value{page}=2
        \draw[black,opacity=.12,line width=.25pt]
          ([xshift=-14mm,yshift=-18mm]current page.north east) --
          ([xshift=-14mm,yshift=12mm]current page.south east);
      \else
        \ifnum\value{part}>0 \NHISDrawOutsideIndex \fi
      \fi
    \end{tikzpicture}%
  \fi
  \fi
}

\newtcolorbox{NHISCallout}{colback=NHISGray,colframe=NHISTeal,boxrule=.7pt,
  arc=1mm,left=3mm,right=3mm,top=2mm,bottom=2mm,before skip=7pt,after skip=7pt}
\newtcolorbox{NHISPrompt}{colback=NHISGray,colframe=NHISGold,boxrule=.8pt,
  arc=1mm,left=3mm,right=3mm,top=2mm,bottom=2mm,before skip=7pt,after skip=7pt}

\newcommand{\NHISCover}{%
  \begin{titlepage}\thispagestyle{empty}\pagecolor{NHISInk}\color{white}\sffamily
  \noindent{\color{white}\small\bfseries 2026 국민건강보험공단 실무 특강}\hfill
  \IfFileExists{assets/top_logo.pdf}{\includegraphics[width=25mm]{assets/top_logo.pdf}}{}\par
  \vspace{24mm}
  {\small\bfseries\color{NHISTeal} AI DOCUMENT AUTOMATION WORKBOOK}\par\vspace{8mm}
  {\NHISDisplayFont\Huge\color{white} AI 시대의\\[2mm] 보고서 자동화\\[2mm] 실무}\par\vspace{8mm}
  {\large 공단 통계 예시로 배우고,\newline 표본코호트 업무로 확장하는\newline 문서 자동화}\par
  \vspace{14mm}{\color{NHISRed}\Large\textbullet}\hspace{1mm}{\color{NHISGold}\Large\textbullet}\hspace{1mm}{\color{green}\Large\textbullet}\hspace{1mm}{\color{NHISTeal}\Large\textbullet}\par
  \vfill
  \IfFileExists{assets/keyboard.pdf}{\centering\includegraphics[width=.62\textwidth]{assets/keyboard.pdf}\par}{}
  \vfill
  \noindent\textcolor{white}{\rule{\textwidth}{.5pt}}\par
  {\color{white}\bfseries 슬기로운 통계생활 (Statistics Playbook) × 국민건강보험공단}\par
  \hfill 발행일자: 2026. 09. 28
  \end{titlepage}\nopagecolor
}
\AtBeginDocument{\NHISCover}
\newcommand{\NHISBackCover}{%
  \clearpage\global\NHISBackCovertrue\begin{titlepage}\thispagestyle{empty}\pagecolor{NHISInk}\color{white}\sffamily
  \IfFileExists{assets/top_logo.pdf}{\includegraphics[width=30mm]{assets/top_logo.pdf}}{}\hfill
  \colorbox{NHISNavy}{\color{white}\small 국민건강보험 실무 특강}\par
  \vfill
  \begin{center}
  {\color{NHISRed}\Large\textbullet}\hspace{1mm}{\color{NHISGold}\Large\textbullet}\hspace{1mm}{\color{green}\Large\textbullet}\hspace{1mm}{\color{NHISTeal}\Large\textbullet}\par\vspace{4mm}
  {\NHISDisplayFont\Large 데이터로 세상을 슬기롭게, AI로 공단 업무를 여유롭게}\par\vspace{4mm}
  {\small Empowering NHIS Professionals with Data Science \& AI Automation}
  \end{center}
  \vfill
  \noindent\rule{\textwidth}{.4pt}\par
  {\small\bfseries 슬기로운 통계생활 (Statistics Playbook)}\par
  {\small 공식 웹사이트: statisticsplaybook.com \quad 교육 문의: support@statisticsplaybook.com}\par
  {\small 발행처: 슬기로운 통계생활 \quad 대표자: 이삭}\par
  {\footnotesize 본 교재는 국민건강보험공단 실무자 교육용으로 특별 제작된 비매품입니다.}
  \end{titlepage}\nopagecolor
}

% Quarto keeps the part/chapter hierarchy and TOC; only the part opener is restyled.
% Quarto emits an empty chapter for the blank index.qmd; suppress just that phantom page.
\newcommand{\NHISInstallChapterSkip}{%
  \let\NHISOriginalChapter\chapter
  \RenewDocumentCommand{\chapter}{s o m}{%
    \IfBlankTF{##3}{}{%
      \IfBooleanTF{##1}{\NHISOriginalChapter*{##3}}{%
        \IfNoValueTF{##2}{\NHISOriginalChapter{##3}}{\NHISOriginalChapter[##2]{##3}}%
      }%
    }%
  }%
}
\AddToHook{begindocument/end}{\NHISInstallChapterSkip}
\RenewDocumentCommand{\part}{m}{%
  \clearpage\global\NHISPartPagetrue\refstepcounter{part}%
  \gdef\NHISCurrentPartTitle{#1}%
  \addcontentsline{toc}{part}{\protect\numberline{\Roman{part}.}#1}%
  \thispagestyle{empty}%
  \ifnum\value{part}=1
    \definecolor{NHISPartColor}{HTML}{282A2C}%
    \definecolor{NHISPartAccent}{HTML}{D64B3C}%
  \else
    \definecolor{NHISPartColor}{HTML}{168F95}%
    \definecolor{NHISPartAccent}{HTML}{168F95}%
  \fi
  \begin{tikzpicture}[remember picture,overlay]
    \fill[NHISPartColor] (current page.north west) rectangle ([xshift=70mm]current page.south west);
    \begin{scope}
      \clip (current page.north west) rectangle ([xshift=70mm]current page.south west);
      \fill[pattern=north east lines,pattern color=white!12!NHISPartColor]
        (current page.north west) rectangle ([xshift=70mm]current page.south west);
    \end{scope}
    \fill[white] ([xshift=70mm]current page.south west) circle[radius=8mm];
    \node[anchor=north west,text=gray,font=\sffamily\small]
      at ([xshift=94mm,yshift=-35mm]current page.north west)
      {2026년도 건보공단 실무 특강 워크북};
    \node[anchor=north west,text=NHISInk,font=\sffamily\bfseries\small]
      at ([xshift=94mm,yshift=-41mm]current page.north west)
      {슬기로운 통계생활 × 국민건강보험};
  \end{tikzpicture}%
  \vspace*{27mm}%
  \noindent\hspace*{76mm}\begin{minipage}[t]{108mm}
    \vspace*{30mm}%
    {\NHISDisplayFont\fontsize{36}{40}\selectfont\color{NHISPartAccent}\Roman{part}.}%
    \hspace{2mm}\raisebox{-1mm}{\begin{tikzpicture}[x=1mm,y=1mm]
      \ifnum\value{part}=1
        \fill[NHISRed] (0,0) rectangle (3,9);
        \fill[NHISGold] (4,0) rectangle (7,10);
        \fill[NHISTeal] (8,0) rectangle (11,9);
        \fill[NHISNavy] (12,0) rectangle (15,10);
      \else
        \fill[NHISTeal] (0,0) rectangle (3,9);
        \fill[NHISGold] (5,0) rectangle (8,7);
        \fill[NHISRed] (10,0) rectangle (13,12);
      \fi
    \end{tikzpicture}}\par
    \vspace{10mm}%
    {\NHISDisplayFont\fontsize{22}{29}\selectfont\color{NHISPartAccent}#1\par}%
    \vspace{4mm}{\color{NHISPartAccent}\rule{\linewidth}{.7pt}}\par\vspace{5mm}
    \begin{minipage}{\linewidth}\sffamily\normalsize\color{NHISInk}
    \ifnum\value{part}=1
      1. 빈 문서에서 만드는 공단형 보고서\par\vspace{3mm}
      2. 가상 요양기관 집계표\par
    \else
      3. 같은 데이터로 만드는 그래프\par\vspace{3mm}
      4. 준비한 그림 삽입하기\par
    \fi
    \end{minipage}
  \end{minipage}%
  \clearpage\global\NHISPartPagefalse
}
