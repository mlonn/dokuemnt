% Modified by Mikael Lönn & Simon Sundström
% https://github.com/olbruket/dokument.git
% Modified by Johan "Horv" Andersson
% https://github.com/cthit/dokument/blob/master/classes/cthit.cls
% Original by Adam Sandberg Ericsson
% https://github.com/dtekcth/dtek-tex/blob/master/dtek.cls

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{olbruket}[2018/10/12 Föreningen Ölbruket Chalmers]

\newif\ifincludeaddress
\includeaddresstrue
\DeclareOption{noincludeaddress}{\includeaddressfalse}

\newif\ifincludeauthors
\includeauthorstrue
\DeclareOption{noincludeauthors}{\includeaddressfalse}

\newif\ifpagination
\paginationtrue
\DeclareOption{nopagination}{\paginationfalse}

\ProcessOptions\relax

\LoadClass[11pt, a4paper]{article}

\RequirePackage[quiet]{fontspec}
\RequirePackage{enumitem}
\RequirePackage{parskip}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage[swedish]{babel}
\RequirePackage{lastpage}
\RequirePackage[unicode]{hyperref}
\RequirePackage[includeheadfoot, top=2.0cm, bottom=4cm]{geometry}
\RequirePackage{xparse}
\RequirePackage{etoolbox}

\RequirePackage{pdfpages}

\definecolor{linkblue}{HTML}{0000ee}


\AtBeginDocument{
 \hypersetup{
   pdftitle = {\@title},
   pdfauthor = {\@author},
   colorlinks=true,
   citecolor=black,
   filecolor=black,
   linkcolor=black
 }
}

\newenvironment{att}{
  \begin{list}{\small{\textbf{att}}}{}
}{
  \end{list}
}

\DeclareDocumentCommand \paragraphref {m}{%
    §\ref{#1}%
}

 %mbox to prevent line-breaking on name
\DeclareDocumentCommand \OLBRUKET {}{\mbox{Ölbruket}}
\DeclareDocumentCommand \OLBRUKETFULL {}{%
  Föreningen \OLBRUKET{}%
}

\DeclareDocumentCommand \MYhref { O{linkblue} m m }{%
  \href{#2}{\color{#1}{#3}}%
}

\DeclareDocumentCommand \subtitle {m} {%
  \DeclareDocumentCommand \@subtitle {}{#1}
}

\DeclareDocumentCommand \approved {m} {%
  \DeclareDocumentCommand \@approved {}{#1}
}

\DeclareDocumentCommand \revisioned {m} {%
  \DeclareDocumentCommand \@revisioned {}{#1}
}

\DeclareDocumentCommand \editorial {m} {%
  \DeclareDocumentCommand \@editorial {}{#1}
}

\DeclareDocumentCommand \authors {m} {%
  \DeclareDocumentCommand \@authors {}{#1}
}

\DeclareDocumentCommand \maketitle {} {%

      \begin{center}
        \vspace*{0.5cm}


        {\bf\Huge \@title\par}

        \vspace{0.2cm}
        \ifdef{\@subtitle}{{\LARGE \@subtitle\par}}{}

        \vspace{0.2cm}

        {\Large
        \textbf{\OLBRUKETFULL{}{}}} \\
        \textbf{En del av Chalmers studentkår}

        \vspace{2cm}
        \centerline{ \includegraphics[width=0.5\textwidth]{olbruket-logo.eps}}
        \vspace{2cm}

        \Large

        \ifincludeauthors
          \ifdef{\@authors}{{\@authors}}{}
          \vspace{2cm}
        \fi

        \ifdef{\@approved}{{Antagen: \@approved \\}}{}
        \ifdef{\@revisioned}{{Reviderad: \@revisioned}}{}
        \ifdef{\@editorial}{{Redaktionell revidering: \@editorial}}{}


    \end{center}
}


\DeclareDocumentCommand \makesimpletitle {} {%

    \begin{center}
        \vspace*{0.5cm}


        {\bf\Huge \@title\par}

        \vspace{0.2cm}
        \ifdef{\@subtitle}{{\LARGE \@subtitle\par}}{}

        \ifincludeauthors
          \ifdef{\@authors}{{\Large\@authors}}{}
          \vspace{2cm}
        \fi

    \end{center}
}

% Set up headers

\DeclareDocumentCommand \makehf {}{%
  \pagestyle{fancy}
  \fancyhf{}

  \newcommand{\headleft}{%
    \raisebox{-3mm}{\includegraphics[width=16mm]{olbruket-logo}}\hspace{1mm}
    \parbox[b]{12cm}{%
      \textbf{\OLBRUKETFULL{}{}}\\
      Chalmers studentkår\\
      \@title
    }
  }

  \newcommand{\headright}{%
    Orgnr: 802511-5844\\
    \ifpagination
      Sida \thepage\ av \pageref{LastPage}\\
    \fi
    \ifdef{\@revisioned}{{\@revisioned}}{}
  }

  % Calculate header height
  \settototalheight\headheight{\headleft}
  \addtolength\headheight{1.0pt}

  \lhead{\headleft}

    \rhead{\headright}


  \renewcommand{\headrule}{
    \nointerlineskip
    \hskip 16mm\hrulefill
  }

  \renewcommand{\footrulewidth}{\headrulewidth}

  \ifincludeaddress

    \lfoot{%
      \flushleft \OLBRUKETFULL{}{}\\
      Teknologgården 2\\
      412 58 Göteborg
    }

    \rfoot{%
      \begin{flushright}
        \href{mailto:styrelse@olbruket.se}{styrelse@olbruket.se}\\
        \href{https://olbruket.se}{https://olbruket.se}
      \end{flushright}
    }
  \fi
}

\DeclareDocumentCommand \makeheadfoot {}{\makehf}

\DeclareDocumentCommand \makesign {m} {%
  \parbox{0.47\textwidth}{%
    \vspace{2cm}
    \rule{0.47\textwidth}{0.5pt}\\
    #1
  }
}

\endinput
