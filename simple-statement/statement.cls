% adapted from ministat.cls and moderncv.cls
\ProvidesClass{statement}[2026/09/12 simple statement]

% Default 11pt (as in recent grant variants); pass unknown options
% through so e.g. \documentclass[12pt]{statement} works.
\def\statement@ptsize{11pt}
\DeclareOption{10pt}{\def\statement@ptsize{10pt}}
\DeclareOption{11pt}{\def\statement@ptsize{11pt}}
\DeclareOption{12pt}{\def\statement@ptsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[\statement@ptsize,letterpaper]{article} % Font size and paper type

% PACKAGES
% Document Formatting
\RequirePackage[margin=1in]{geometry}
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage{parskip}
\RequirePackage{fancyhdr}
\RequirePackage[table]{xcolor}

% VARIABLES: name and statement type
\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \statement#1{\def\@statement{#1}} % Defines the \statement command to set type of statement
\def \@statement {} % Sets \@statement to empty by default

% VARIABLES: colors
\definecolor{color0}{rgb}{0,0,0}% main default color, normally left to black
\definecolor{color1}{rgb}{0.22,0.45,0.70}% light blue % primary scheme color
\definecolor{color2}{rgb}{0.45,0.45,0.45}% dark grey % secondary scheme color
\definecolor{color3}{rgb}{0,0,0}% tertiary scheme color

% UTILS
% creates a length if not yet defined
\newcommand*{\@initializelength}[1]{%
  \ifdefined#1
  \else%
    \newlength{#1}\fi%
  \setlength{#1}{0pt}}

% FORMATTING
\renewcommand{\maketitle}{
\thispagestyle{plain}
{\LARGE \@name} \hfill {\large\sc \@statement}
\vspace{5pt}{\color{color1}\hrule}\vspace{5pt}
}

% mark the total number of pages
\AtEndPreamble{\AtEndDocument{\label{lastpage}}}

% page style
% top: name, statement at the top, page number at the bottom
\fancypagestyle{top}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}
  %\fancyhead[L]{\@statement}
  %\fancyhead[R]{\@name}
  \fancyfoot[R]{\thepage}
}
% bottom: name, statement, page number all at the bottom
\fancypagestyle{bottom}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}
  \fancyfoot[L]{\@name}
  \fancyfoot[C]{\@statement}
  \fancyfoot[R]{\thepage}
}
% plain: page number only at the bottom
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}
  % \fancyfoot[L]{\it \@name}
  % \fancyfoot[C]{\it \@statement}
  \fancyfoot[R]{\thepage}
}
% none: nothing
\fancypagestyle{none}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}
}
\pagestyle{top}

% pdf metadata
\AtEndPreamble{
  \pagenumbering{arabic}% has to be issued before loading hyperref, as to set \thepage and hence to avoid hyperref issuing a warning and setting pdfpagelabels=false
  \RequirePackage[unicode]{hyperref}% unicode is required for unicode pdf metadata
  \hypersetup{
    breaklinks,
    pdfborder     = 0 0 0,
    pdfpagemode   = UseNone,
    pdfstartpage  = 1,
    pdfcreator    = {\LaTeX{}},
%    pdfproducer   = {\LaTeX{}},% will/should be set automatically to the correct TeX engine used
    bookmarksopen = true,
    bookmarksdepth= 2,% to show sections and subsections
    pdfauthor     = {\@name},
    pdftitle      = {\@name~--~\@statement},
    pdfsubject    = {\@statement~of~\@name},
    pdfkeywords   = {\@name, \@statement},
    linkcolor=black,
    citecolor=black,
    anchorcolor=black,
    filecolor=black,
    menucolor=black,
    runcolor=black,
    urlcolor=black,
    hidelinks,
  }
  \usepackage[nameinlink]{cleveref}
}

% section - same font as text, underlined and bolded
\RenewDocumentCommand{\section}{sm}{
  \par\addvspace{1ex}
  \phantomsection{} % reset the anchor for hyperrefs
  \addcontentsline{toc}{section}{#2} % add to table of content
  \underline{\normalsize\mdseries\upshape\bf
  \IfBooleanF{#1}
    {\refstepcounter{section}\csname thesection\endcsname\quad}
  #2}
  \par\nobreak\addvspace{0.5ex}\@afterheading % avoid pagebreak after heading
}

\RenewDocumentCommand{\subsection}{sm}{
  %\par\addvspace{1ex}
  %\phantomsection{} % reset the anchor for hyperrefs
  %\addcontentsline{toc}{section}{#2} % add to table of content
  {\normalsize\mdseries\upshape\bf
  \IfBooleanF{#1}
    {\refstepcounter{subsection}\csname thesection\endcsname\quad}
  #2}
  \par\nobreak\@afterheading % avoid pagebreak after heading
}

% Bold section header without underline (used in recent grant variants).
\newcommand{\MySection}[1]{%
  \par\addvspace{1pt}%
  \phantomsection{}%
  \addcontentsline{toc}{section}{#1}%
  {\noindent\normalsize\bfseries #1}%
  \par\nobreak\vspace{-2pt}\@afterheading%
}

% renew page & section numbers between different statements
\newcommand{\statementend}{%
  \clearpage\newpage
  \setcounter{page}{1}
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \setcounter{footnote}{0}
}
