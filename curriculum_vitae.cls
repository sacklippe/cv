%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Twenty Seconds Curriculum Vitae in LaTex
% ****************************************
% 
% License: MIT
%
% For further information please visit:
% https://github.com/spagnuolocarmine/TwentySecondsCurriculumVitae-LaTex
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%
% CLASS %
%%%%%%%%%
\ProvidesClass{curriculum_vitae}[2015/02/28 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%%%%%%%%%%%%
% PACKAGES %
%%%%%%%%%%%%
\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\RequirePackage{fontawesome5}
\RequirePackage{etoolbox}
\RequirePackage{tabularx}
\RequirePackage{makecell}
\RequirePackage{enumitem}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%%%%%%%%%%%
% OPTIONS %
%%%%%%%%%%%
% icons
\newbool{icon}
\DeclareOption{icon}{%
  \booltrue{icon}
}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\ifbool{icon}{\RequirePackage{fontawesome}}{}

\usetikzlibrary{calc}

%%%%%%%%%%
% COLORS %
%%%%%%%%%%
\definecolor{white}{RGB}{255,255,255} 
\definecolor{darkgray}{HTML}{333333} 
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{lightgray}{HTML}{999999}
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB0B00}
\definecolor{blue}{HTML}{6CE0F1}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{cerulean}{HTML}{007BA7}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{maindarkgray}{HTML}{B3B3B3}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{asidecolor}{sidecolor}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
  \colorlet{asidecolor}{sidecolor}
\fi

\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%%%%%%%%%%%%%%%
% MISC CONFIGURATIONS %
%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\bfseries}{\color{gray}} % Make \textbf produce coloured text instead
\pagestyle{empty} % Disable headers and footers
\setlength{\parindent}{0pt} % Disable paragraph indentation

%%%%%%%%%%%%%%%%%%%%%%%%
% Profile left SideBar %
%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\settowidth{\SectionTitleLength}{\huge #1 }% Calculate the width of the section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand{\cvgit}[1]{\renewcommand{\cvgit}{#1}}

% icon in blue circle; #1 -> icon
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{
  \node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}
}

% Custom element
\newlength{\tecelementheight}
\setlength{\tecelementheight}{12pt} 
\newcommand{\tecelement}[1]{%
  \begin{tikzpicture}[baseline=-0.5*\tecelementheight]  % Adjusting the baseline
    \node[draw=mainblue, fill=mainblue, text=white, inner sep=1.6pt, rounded corners, align=center, minimum height=\tecelementheight, font=\small] {#1};
  \end{tikzpicture}
}

% Custom large centered dot with equal spacing
\newcommand{\largedot}{\hspace{0.5em}\raisebox{-0.5ex}{\large\textbullet}\hspace{0.5em}} 

% skill bar graphs
\newcommand\skills[1]{ 
	\renewcommand{\skills}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (6,\i+0.4);
				\draw[fill=white,mainblue](0,\i) rectangle (\y,\i+0.4);
				\node [above right] at (0,\i+0.4) {\x};
			}
		\end{tikzpicture}
	}
}

% skill list
\newcommand{\renderskills}{} % default, does nothing
\newcommand{\skillslist}[1]{ 
    \renewcommand{\renderskills}{
        \begin{flushleft}
            \foreach \skill in {#1} {
                \tecelement{\skill}\hspace{1pt}
            }
        \end{flushleft}
    }
}

% languages
\newtoks\languagelist
\newcommand{\addcvlanguage}[2]{%
    \ifx\empty\languagelist\relax % Check if the list is empty
        \languagelist={#1 & #2}%
    \else
        \languagelist=\expandafter{\the\languagelist \\ #1 & #2}%
    \fi
}
\newcommand{\renderlanguages}{%
    \renewcommand{\arraystretch}{1.3}
    \begin{tabularx}{0.8\linewidth}{>{\bfseries}l@{\hspace{10pt}}X} % Adjust the 10pt to your liking
        \the\languagelist
    \end{tabularx}
}

% awards
\newtoks\awardlist
\newcommand{\addcvaward}[2]{%
    \ifx\empty\awardlist\relax % Check if the list is empty
        \awardlist={#1 & #2}%
    \else
        \awardlist=\expandafter{\the\awardlist \\ #1 & #2}%
    \fi
}
\newcommand{\renderawards}{%
    \renewcommand{\arraystretch}{1.3}
    \begin{tabularx}{\linewidth}{@{} >{\bfseries}l @{\hspace{10pt}} X @{}}
        \the\awardlist
    \end{tabularx}
}

% extracurricular courses
\newtoks\courselist
\newcommand{\addcvcourse}[2]{
    \ifx\empty\courselist\relax % Check if the list is empty
        \courselist={#1 & #2}
    \else
        \courselist=\expandafter{\the\courselist \\ #1 & #2}%
    \fi
}
\newcommand{\rendercourses}{%
    \renewcommand{\arraystretch}{1.3}
    \begin{tabularx}{\linewidth}{@{} >{\bfseries}l @{\hspace{10pt}} X @{}}
        \the\courselist
    \end{tabularx}
}

% list of technologies
\newcommand\tectext[1]{ 
  \begin{flushleft}
    \foreach \skill in {#1}{ 
      \tecelement{\skill}\hspace{0.5pt} % Adjust the horizontal space between elements
    }
  \end{flushleft}
}

%%%%%%%%%%%%%%%%%%
% SIDEBAR LAYOUT %
%%%%%%%%%%%%%%%%%%
\newcommand{\createsidebar}{
    \begin{tikzpicture}[remember picture,overlay]
        \node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
    \end{tikzpicture}
}

% 1st page
\newcommand{\makeprofile}{
	\createsidebar
	\begin{textblock}{6}(0.5, 0.2)

        % profile picture
		\ifthenelse{\equal{\profilepic}{}}{}{
			\begin{center}
				\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
					\clip (600/2, 567/2) circle (567/2);
					\node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
				\end{tikzpicture}
			\end{center}
		}

        % profile info
		{\Huge\color{mainblue}\cvname} \\
        [0.5\baselineskip]
		{\Large\color{black!80}\cvjobtitle} \\
        [0.5\baselineskip]
        \renewcommand{\arraystretch}{1.6}
        \newcommand{\personalinfo}{
            \renewcommand{\arraystretch}{1.6}
            \begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
                \ifthenelse{\equal{\cvdate}{}}{}{\textsc{\color{mainblue}\Large\faIcon{calendar-alt}} & \cvdate\\}
                \ifthenelse{\equal{\cvaddress}{}}{}{\textsc{\color{mainblue}\Large\faIcon{map-marker-alt}} & \cvaddress\\} 
                \ifthenelse{\equal{\cvnumberphone}{}}{}{\textsc{\color{mainblue}\Large\faIcon{mobile-alt}} & \cvnumberphone\\}
                \ifthenelse{\equal{\cvmail}{}}{}{\textsc{\color{mainblue}\Large\faIcon{at}} & \href{mailto:\cvmail}{\cvmail}\\}
                \ifthenelse{\equal{\cvsite}{}}{}{\textsc{\color{mainblue}\Large\faIcon{linkedin}} & \cvsite\\}
                \ifthenelse{\equal{\cvgit}{}}{}{\textsc{\color{mainblue}\Large\faIcon{github}} & \cvgit}
            \end{tabular}
        }
        \personalinfo

        % about me
		\ifthenelse{\equal{\aboutme}{}}{}{
			\profilesection{About me}
			\begin{flushleft}
				\aboutme
			\end{flushleft}
		}

        % skills
		\profilesection{Skills}
		\skills
        \renderskills

	\end{textblock}
}

% 2nd page
\newcommand{\makenextprofile}{
	\createsidebar
	\begin{textblock}{6}(0.5, 0.2)

        \profilesection{Languages}
        \renderlanguages

        \profilesection{Awards}
        \renderawards

        \profilesection{Extracurricular}
        \rendercourses
			
	\end{textblock}
}

%%%%%%%%%%%%%%%%%%%%%
% SECTION COLOR BOX %
%%%%%%%%%%%%%%%%%%%%%
\newcommand*\round[1]{
	\tikz[baseline=(char.base)]\node[anchor=north west, draw, rectangle, rounded corners, inner sep=1.6pt, minimum size=5.5mm, text height=3.6mm, fill=maingray, text=white](char){#1};%
}
\renewcommand{\section}[1]{
	{
		\color{maingray}
		\Large\round{#1}
	}
}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{
		\large\color{gray} #1
	}
	\par\vspace{.25\parskip}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LIST TWENTY ENVIRONMENT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% long list
\setlength{\tabcolsep}{0pt}
\newenvironment{twenty}{
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}
}
\newcommand{\twentyitem}[4]{
	#1&\parbox[t]{0.83\textwidth}{
		\textbf{#2}
		\hfill
		{\footnotesize#3}\\
		#4\vspace{\parsep}
	}\\
}

% short list
\setlength{\tabcolsep}{0pt}
\newenvironment{twentyshort}{
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}
}
\newcommand{\twentyitemshort}[2]{
	#1&\parbox[t]{0.83\textwidth}{
		\textbf{#2}
	}\\
}

%%%%%%%%%%%%%%%%
% PAGE SETTING %
%%%%%%%%%%%%%%%%
\RequirePackage[left=7.3cm,top=0.1cm,right=0.5cm,bottom=0.2cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
