\NeedsTeXFormat{LaTeX2e}
\RequirePackage[english]{babel}
\ProvidesClass{imo_en}[2013/04/14 v0.95 IMO exercise and exam sheet class]

% Passes class options to the underlying article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\newif\if@exercise@exam
\DeclareOption{exam}{\@exercise@examtrue}
\ProcessOptions\relax

\LoadClass[12pt,a4paper]{article}

\RequirePackage[left=1in,right=1in,top=1in,bottom=1in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{common}
\RequirePackage{xifthen}
\RequirePackage{fancybox}

\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{etoolbox}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{MnSymbol}
\RequirePackage{bbm}
\RequirePackage{mathtools}


\providebool{printsolution}

\gdef\@filetitle{}
\newcommand*{\coursetitle}[1]{\gdef\@coursetitle{#1}}
\newcommand*{\courseurl}[1]{\gdef\@courseurl{#1}}
\newcommand*{\courseterm}[1]{\gdef\@courseterm{#1}}
\newcommand{\coursepeople}[1]{\gdef\@coursepeople{#1}}
\newcommand{\coursegraphic}[1]{\gdef\@coursegraphic{#1}}

\coursetitle{$\backslash$coursetitle}
\courseterm{$\backslash$courseterm}
\coursepeople{$\backslash$coursepeople}
\coursegraphic{$\backslash$coursegraphic}
\courseurl{}

\newcommand{\sheetdeadline}[1]{\gdef\@sheetdeadline{#1}}
\sheetdeadline{}
\newcommand{\examname}[1]{\gdef\@examname{#1}}
\examname{Exam}
\newcommand{\examduration}[1]{\gdef\@examduration{#1}}
\examduration{90}
\newcommand{\examdate}[1]{\gdef\@examdate{#1}}
\examdate{??.??.20??}
\pgfkeyssetvalue{/options/additionalfield}{}
\pgfkeyssetvalue{/options/examresult}{}
\pgfkeyssetvalue{/options/bonuspoints}{}
\newcommand{\examoptions}[1]{\pgfqkeys{/options}{#1}}
\gdef\@filetitle{\@coursetitle~--~\if@exercise@exam{\@examname}\else{Series~\thesheetnumber}\fi}


\setlength{\parindent}{0mm}
\newcounter{taskcounter}
\setlength{\headheight}{15pt}
\fancypagestyle{firstpage}{%
\fancyhf{} % clear all six fields
\fancyfoot[RO]{p.~\thepage/\pageref{LastPage}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.3pt}
}
\fancypagestyle{followingpage}{%
\fancyhf{} % clear all six fields
\fancyhead[CO]{}
\fancyhead[LO]{\@filetitle}
\fancyhead[RO]{p.~\thepage/\pageref{LastPage}}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}
}
\pagestyle{followingpage}
\AtBeginDocument{\thispagestyle{firstpage}}

\newcounter{sheetnumber}
\NewDocumentCommand\sheetnumber{m}{\setcounter{sheetnumber}{#1}}

\DeclareDocumentCommand\@printtaskcounter{}{\arabic{sheetnumber}.\arabic{taskcounter}}

% header command
\DeclareDocumentCommand\makeheader{}{
  \vspace*{-1cm}
  \hrule
  \medskip
  \begin{minipage}{80mm}
    {\@coursepeople} \\
    {\@courseterm}
  \end{minipage}
  \hfill
  \begin{minipage}{75mm}
    \begin{flushright}
      {\@coursegraphic}
    \end{flushright}
  \end{minipage}
  \begin{center}
    {\Large\textbf{\@coursetitle~--~Series~\arabic{sheetnumber}}%
    \ifbool{printsolution}{\\(with solutions)}{}} \\
    {\ifx\@courseurl\@empty{}\else{% 
    \medskip 
    {\small \url{\@courseurl}} \\
    }\fi}
    \ifx\@sheetdeadline\@empty{}\else{%
    \bigskip
    \@sheetdeadline}\fi
  \end{center}
  \hrule
  \bigskip
}

% pointed line for student entries
\def\underdotline#1{{\leavevmode\setbox0=\hbox{#1}% 
 \rlap{\raise-0.28em\hbox to\wd0{\rm\cleaders\hbox{.\kern-0.1ex}\hfill}} 
 \box0}} 

% coverpage for exams
\DeclareDocumentCommand\makeexamcoverpage{}{
  \RenewDocumentCommand\@printtaskcounter{}{\arabic{taskcounter}}
  \vspace*{-1cm}
  \thispagestyle{empty}
  \setcounter{page}{0}
  \hrule
  \medskip
  \begin{minipage}{80mm}
    {\@coursepeople} \\
    {\@courseterm}
  \end{minipage}
  \hfill
  \begin{minipage}{75mm}
    \begin{flushright}
      {\@coursegraphic}
    \end{flushright}
  \end{minipage}
  \begin{center}
    {\Large\textbf{\@examname~\@coursetitle%
      \ifbool{printsolution}{\\(with solutions)}}} \\
    {\ifx\@courseurl\@empty{}\else{% 
    \medskip 
    {\small \url{\@courseurl}} \\
    }\fi}
    \bigskip
    \@examdate
  \end{center}
%  \hrule
\vspace{1.2cm}
\begin{center}
\begin{minipage}{.8\textwidth}
Last name: \hfill \underdotline{\hspace{9cm}}\\\\
First name: \hfill \underdotline{\hspace{9cm}}\\\\
Student No: \hfill \underdotline{\hspace{9cm}}\\\\
\ifthenelse{\equal{\pgfkeysvalueof{/options/additionalfield}}{}}{}{%
\pgfkeysvalueof{/options/additionalfield}: \hfill \underdotline{\hspace{9cm}}\\\\
}
\end{minipage}
\end{center}
\vfill
\begin{center}
{\bf Please note:}
\end{center}
\begin{itemize} 
\item Write your name and student number on every sheet!
\item Start answering a new task on a new sheet of paper.
\item Every statement has to be justified precisely. 
\item The working time is \@examduration~minutes.
\end{itemize} 
\begin{center}
{\bf Good luck!}
\end{center}
\vfill
\begin{center}
\bfseries
\exerciseExamTable
\end{center}
\ifthenelse{\equal{\pgfkeysvalueof{/options/bonuspoints}}{}}{}{%
Bonus points: \underdotline{\hspace{1cm}}%
}%
\hfill
\ifthenelse{\equal{\pgfkeysvalueof{/options/examresult}}{}}{}{%
{\setlength{\fboxsep}{7pt}\doublebox{\textbf{\pgfkeysvalueof{/options/examresult}:}~\phantom{gggXXXXX}}}%
}%
\vfill
\hrule
\clearpage
}

\DeclareDocumentCommand\pleaseTurn{}{
  \notbool{printsolution}{
    \medskip
    \vfill \hfill Please turn the page! \newpage
  }
}
% conditional pagebreaking
\newcommand{\clearpagequestions}{\ifbool{printsolution}{}{\protect\clearpage}}
\newcommand{\clearpagesolutions}{\ifbool{printsolution}{\protect\clearpage}{}}


\def\maketitle{\if@exercise@exam{\makeexamcoverpage}\else{\makeheader}\fi}
\AtBeginDocument{\hypersetup{%
  pdftitle={\@filetitle%
  \ifbool{printsolution}{~(with solutions)}{}},%
  pdfauthor={\@coursepeople}%
}}


