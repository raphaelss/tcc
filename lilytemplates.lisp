(defparameter *max-mult* #((* 4 2) (* 4 3) (* 4 4) (* 4 5) (* 4 6) (* 4 7)))
(defparameter *pc-name-vec* #("c" "des" "d" "ees" "e" "f" "ges"
                              "g" "aes" "a" "bes" "b"))
(defparameter *mult-tuplet* #(#("~a8~a") ;2
                              #("~a8~a" "~a4~a") ;3
                              #("~a16~a" "~a8~a" "~a8.~a") ;4
                              #("~a16~a" "~a8~a" "~a8.~a" "~a4~a") ;5
                              #("~a16~a" "~a8~a" "~a8.~a" "~a4~a"
                                "~a8.~a~[~~~] ~0@*~a8") ;6!!!
                              #("~a16~a" "~a8~a" "~a8.~a" "~a4~a"
                                "~a4~a~[~~~] ~0@*~a16" "~a4.~a"))) ;7
(defparameter
    *mult-fig* #(#("~a8~a"  ;2.1
                   "~a4~a"  ;.2
                   "~a4.~a" ;.3
                   "~a2~a"  ;.4
                   "~a2~a~[~~~] ~0@*~a8" ;.5
                   "~a2.~a" ;.6
                   "~a2.~a~[~~~] ~0@*~a8" ;.7
                   "~a1~a") ;.8
                 #("\\times 2/3 {~a8~a" ;3.1
                   "\\times 2/3 {~a4~a" ;.2
                   "~a4~a" ;.3
                   "~a4~a~[~~~] \\times 2/3 {~0@*~a8" ;.4
                   "~a4~a~[~~~] \\times 2/3 {~0@*~a4" ;.5
                   "~a2~a" ;.6
                   "~a2~a~[~~~] \\times 2/3 {~0@*~a8" ;.7
                   "~a2~a~[~~~] \\times 2/3 {~0@*~a4" ;.8
                   "~a2.~a" ;.9
                   "~a2.~a~[~~~] \\times 2/3 {~0@*~a8" ;.10
                   "~a2.~a~[~~~] \\times 2/3 {~0@*~a4" ;.11
                   "~a1~a") ;12
                 #("~a16~a" ;4.1
                   "~a8~a" ;.2
                   "~a8.~a" ;.3
                   "~a4~a" ;.4
                   "~a4~a~[~~~] ~0@*~a16" ;.5
                   "~a4.~a" ;.6
                   "~a4~a~[~~~] ~0@*~a8." ;.7
                   "~a2~a" ;.8
                   "~a2~a~[~~~] ~0@*~a16" ;.9
                   "~a2~a~[~~~] ~0@*~a8" ;.10
                   "~a2~a~[~~~] ~0@*~a8." ;.11
                   "~a2.~a" ;.12
                   "~a2.~a~[~~~] ~0@*~a16" ;.13
                   "~a2.~a~[~~~] ~0@*~a8" ;.14
                   "~a2.~a~[~~~] ~0@*~a8." ;.15
                   "~a1~a") ;.16
                 #("\\times 4/5 {~a16~a" ;5.1
                   "\\times 4/5 {~a8~a" ;.2
                   "\\times 4/5 {~a8.~a" ;.3
                   "\\times 4/5 {~a4~a" ;.4
                   "~a4~a" ;.5
                   "~a4~a~[~~~] \\times 4/5 {~0@*~a16" ;.6
                   "~a4~a~[~~~] \\times 4/5 {~0@*~a8" ;.7
                   "~a4~a~[~~~] \\times 4/5 {~0@*~a8." ;.8
                   "~a4~a~[~~~] \\times 4/5 {~0@*~a4" ;.9
                   "~a2~a" ;.10
                   "~a2~a~[~~~] \\times 4/5 {~0@*~a16" ;.11
                   "~a2~a~[~~~] \\times 4/5 {~0@*~a8" ;.12
                   "~a2~a~[~~~] \\times 4/5 {~0@*~a8." ;.13
                   "~a2~a~[~~~] \\times 4/5 {~0@*~a4" ;.14
                   "~a2.~a" ;.15
                   "~a2.~a~[~~~] \\times 4/5 {~0@*~a16" ;.16
                   "~a2.~a~[~~~] \\times 4/5 {~0@*~a8" ;.17
                   "~a2.~a~[~~~] \\times 4/5 {~0@*~a8." ;.18
                   "~a2.~a~[~~~] \\times 4/5 {~0@*~a4" ;.19
                   "~a1~a") ;.20
                 #("\\times 4/6 {~a16~a" ;6.1
                   "\\times 4/6 {~a8~a" ;.2
                   "\\times 4/6 {~a8.~a" ;.3
                   "\\times 4/6 {~a4~a" ;.4
                   "\\times 4/6 {~a4~a~[~~~] ~0@*~a16" ;.5!!!
                   "~a4~a" ;.6
                   "~a4~a~[~~~] \\times 4/6 {~0@*~a16" ;.7
                   "~a4~a~[~~~] \\times 4/6 {~0@*~a8" ;.8
                   "~a4~a~[~~~] \\times 4/6 {~0@*~a8." ;.9
                   "~a4~a~[~~~] \\times 4/6 {~0@*~a4" ;.10
                   "~a4~a~[~~~] \\times 4/6 {~0@*~a8.~*~[~~~] ~0@*~a8" ;.11
                   "~a2~a" ;.12
                   "~a2~a~[~~~] \\times 4/6 {~0@*~a16" ;.13
                   "~a2~a~[~~~] \\times 4/6 {~0@*~a8" ;.14
                   "~a2~a~[~~~] \\times 4/6 {~0@*~a8." ;.15
                   "~a2~a~[~~~] \\times 4/6 {~0@*~a4" ;.16
                   "~a2~a~[~~~] \\times 4/6 {~0@*~a8.~*~[~~~] ~0@*~a8" ;.17
                   "~a2.~a" ;.18
                   "~a2.~a~[~~~] \\times 4/6 {~0@*~a16" ;.19
                   "~a2.~a~[~~~] \\times 4/6 {~0@*~a8" ;.20
                   "~a2.~a~[~~~] \\times 4/6 {~0@*~a8." ;.21
                   "~a2.~a~[~~~] \\times 4/6 {~0@*~a4" ;.22
                   "~a2.~a~[~~~] \\times 4/6 {~0@*~a8.~*~[~~~] ~0@*~a8" ;.23
                   "~a1~a") ;.24
                 #("\\times 4/7 {~a16~a" ;7.1
                   "\\times 4/7 {~a8~a" ;.2
                   "\\times 4/7 {~a8.~a" ;.3
                   "\\times 4/7 {~a4~a" ;.4
                   "\\times 4/7 {~a4~a~[~~~] ~0@*~a16" ;.5
                   "\\times 4/7 {~a4.~a" ;.6
                   "~a4~a" ;.7
                   "~a4~a~[~~~] \\times 4/7 {~0@*~a16" ;.8
                   "~a4~a~[~~~] \\times 4/7 {~0@*~a8" ;.9
                   "~a4~a~[~~~] \\times 4/7 {~0@*~a8." ;.10
                   "~a4~a~[~~~] \\times 4/7 {~0@*~a4" ;.11
                   "~a4~a~[~~~] \\times 4/7 {~0@*~a4~*~[~~~] ~0@*~a16" ;.12
                   "~a4~a~[~~~] \\times 4/7 {~0@*~a4." ;.13
                   "~a2~a" ;.14
                   "~a2~a~[~~~] \\times 4/7 {~0@*~a16" ;.15
                   "~a2~a~[~~~] \\times 4/7 {~0@*~a8" ;.16
                   "~a2~a~[~~~] \\times 4/7 {~0@*~a8." ;.17
                   "~a2~a~[~~~] \\times 4/7 {~0@*~a4" ;.18
                   "~a2~a~[~~~] \\times 4/7 {~0@*~a4~*~[~~~] ~0@*~a16" ;.19
                   "~a2~a~[~~~] \\times 4/7 {~0@*~a4." ;.20
                   "~a2.~a" ;.21
                   "~a2.~a~[~~~] \\times 4/7 {~0@*~a16" ;.22
                   "~a2.~a~[~~~] \\times 4/7 {~0@*~a8" ;.23
                   "~a2.~a~[~~~] \\times 4/7 {~0@*~a8." ;.24
                   "~a2.~a~[~~~] \\times 4/7 {~0@*~a4" ;.25
                   "~a2.~a~[~~~] \\times 4/7 {~0@*~a4~*~[~~~] ~0@*~a16" ;.26
                   "~a2.~a~[~~~] \\times 4/7 {~0@*~a4." ;.27
                   "~a1~a"))) ;.28

(defparameter *lily-version* "\\version \"2.18.2\"")
(defparameter *lily-include* "\\include \"~a\"")
(defparameter *score-header* "#(set-global-staff-size 17)
\\book {
  \\paper {
    #(set-paper-size \"a3\" 'portrait)
    indent = 3.0\\cm
    short-indent = 1.5\\cm
    %top-margin = 20\mm
    %bottom-margin = 20\mm
    %left-margin = 25\mm
    %right-margin = 20\mm
  }
  \\header {
    title = \"~a\"
    subtitle = \"~a\"
    subsubtitle = \"~a\"
    composer = \"Raphael Santos\"
    opus = \"(2014)\"
    tagline = ##f
  }
  \\score {
    <<~%")
(defparameter *score-footer* "    >>~%    \\layout {}~%    \\midi {}~%  }~%}")
(defparameter *group-header* "      \\new StaffGroup = \"~a\" <<~%")
(defparameter *group-footer* "      >>~%")
(defparameter *inline-line* "        \\new Staff {
          \\set Staff.instrumentName = #\"~a\"
          \\set Staff.shortInstrumentName = #\"~a\"
          \\set Staff.midiInstrument = #\"~a\"
          \\new Voice {~%            \\~a
          }~%        }~%")

(defparameter *line-file-header* "~a = {~%")
(defparameter *line-file-footer* "}")
