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
                  ("horniii" "French Horn III" "Fr. Hrn. III" f-horn)
                  ("horniv" "French Horn IV" "Fr. Hrn. IV" f-horn)
                  ("trumpeti" "Trumpet I" "Trpt. I" trumpet)
                  ("trumpetii" "Trumpet II" "Trpt. II" trumpet)
                  ("trumpetiii" "Trumpet III" "Trpt. III" trumpet)
                  ("trombonei" "Trombone I" "Trmb. I" trombone)
                  ("tromboneii" "Trombone II" "Trmb. II" trombone)
                  ("basstrombone" "Bass Trombone" "Bass Trmb." trombone)
                  ("tuba" "Tuba" "Tba." tuba))
                 ("string"
                  ("violinia" "Violin Ia" "Vln. Ia" violin-i)
                  ("violinib" "Violin Ib" "Vln. Ib" violin-i)
                  ("violiniia" "Violin IIa" "Vln. IIa" violin-ii)
                  ("violiniib" "Violin IIb" "Vln. IIb" violin-ii)
                  ("violaa" "Viola a" "Vla. a" viola)
                  ("violab" "Viola b" "Vla. b" viola)
                  ("celloa" "Cello a" "Vlc. a" cello)
                  ("cellob" "Cello b" "Vlc. b" cello)
                  ("bass" "Bass" "Bass" bass)))))

(defparameter *dur-all* '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
                          20 21 22 23 24 25 26 27 28))

(defparameter *dyn-all* '(ppp pp p mp mf f ff fff))

(defun pitch-list-from-root (root)
  (let ((root-pc (pc root))
        (root-oct (octave root)))
    (list root
          (make-instance 'pitch :pc (+ root-pc 7) :octave (1+ root-oct))
          (make-instance 'pitch :pc (+ root-pc 4) :octave (+ root-oct 2))
          (make-instance 'pitch :pc (+ root-pc 10) :octave (+ root-oct 2))
          (make-instance 'pitch :pc (+ root-pc 2) :octave (+ root-oct 3))
          (make-instance 'pitch :pc (+ root-pc 6) :octave (+ root-oct 3))
          (make-instance 'pitch :pc (+ root-pc 8) :octave (+ root-oct 3)))))

(defun instr-fun (label)
  (if (able-to-play label) 1 0))

(defparameter *line*
  (vector
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)
   (timed-dc (score-all-labels *score*) 2 #'instr-fun)))

(defparameter *dyn*
  (vector
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)
   (timed-dc *dyn-all*)))

(defparameter *dur*
  (vector
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)
   (timed-dc *dur-all*)))

(defparameter *pitch*
  (vector
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))
   (timed-dc (mapcar #'(lambda (x) (make-pitch (cons x 4))) '(0 1 2 3 4 5 6 7 8 9 10 11)))))

(defparameter *gen-lines* (make-array 12))
(defparameter *gen-line-list*
  (let ((result nil))
    (dotimes (i 12 result)
      (let ((gen-line (make-instance 'gen-line :base (+ (mod i 6) 2)
                                     :dur (aref *dur* i)
                                     :line (aref *line* i)
                                     :dynamic (aref *dyn* i)
                                     :pitch (aref *pitch* i))))
        (setf (aref *gen-lines* i) gen-line)
        (push gen-line result)
        result))))

(run-until *gen-line-list* 60)
(print-score "scotst.ly" *score*)
