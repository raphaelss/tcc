(require 'asdf)
(setf asdf:*central-registry* '("~/work/tcc/lisp/"))
(asdf:load-system 'dc)

(setf *score* (make-score
               :title "Concerto"
               :spec
               '(("woodwind"
                  ("piccolo" "Piccolo" "Picc." piccolo)
                  ("flutei" "Flute I" "Fl. I" flute)
                  ("fluteii" "Flute II" "Fl. II" flute)
                  ("oboei" "Oboe I" "Ob. I" oboe)
                  ("oboeii" "Oboe II" "Ob. II" oboe)
                  ("enghorn" "Eng. Horn" "Eng. Hn." eng-horn)
                  ("clarineti" "Clarinet Bb I" "Cl. Bb I" clarinet)
                  ("clarinetii" "Clarinet Bb II" "Cl. Bb II" clarinet)
                  ("bassclarinet" "Bass Clarinet" "Bass Cl." bass-clarinet)
                  ("bassooni" "Bassoon I" "Bsn. I" bassoon)
                  ("bassoonii" "Bassoon II" "Bsn. II" bassoon)
                  ("contrabassoon" "Contrabassoon" "Cbsn." contrabassoon))
                 ("brass"
                  ("horni" "French Horn I" "Fr. Hrn. I" f-horn)
                  ("hornii" "French Horn II" "Fr. Hrn. II" f-horn)
                  ("hornii" "French Horn III" "Fr. Hrn. III" f-horn)
                  ("horniv" "French Horn IV" "Fr. Hrn. IV" f-horn)
                  ("trumpeti" "Trumpet I" "Trpt. I" trumpet)
                  ("trumpetii" "Trumpet II" "Trpt. II" trumpet)
                  ("trumpetiii" "Trumpet III" "Trpt. III" trumpet)
                  ("trombonei" "Trombone I" "Trmb. I" trombone)
                  ("tromboneii" "Trombone II" "Trmb. II" trombone)
                  ("basstrombone" "Bass Trombone" "Bass Trmb." trombone)
                  ("tuba" "Tuba" "Tba." tuba))
                 ("string"
                  ("violini" "Violin I" "Vln. I" violin-i)
                  ("violinii" "Violin II" "Vln. II" violin-ii)
                  ("viola" "Viola" "Vla." viola)
                  ("cello" "Cello" "Vlc." cello)
                  ("bass" "Bass" "Bass" bass)))))

(defun instr-fun (instr))

(defparameter *gen-line-list*
  (list
   (make-instance 'gen-line :base 2 :line "string/violini")
   (make-instance 'gen-line :base 3 :line "string/viola")
   (make-instance 'gen-line :base 4 :line "string/violinii")
   (make-instance 'gen-line :base 5 :line "string/cello")
   (make-instance 'gen-line :base 6 :line "string/bass")
   (make-instance 'gen-line :base 7 :line "brass/tuba")
   (make-instance 'gen-line :base 2 :line "brass/basstrombone")
   (make-instance 'gen-line :base 3 :line "brass/horni")
   (make-instance 'gen-line :base 4 :line "brass/hornii")
   (make-instance 'gen-line :base 5 :line "brass/trumpeti")
   (make-instance 'gen-line :base 6 :line "woodwind/flutei")
   (make-instance 'gen-line :base 7 :line "woodwind/oboei")))

(run-until *gen-line-list* 100)
(print-score "scotst.ly" *score*)
