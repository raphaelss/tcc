(setf *score* (make-score
               :title "" :subtitle "" :subsubtitle ""
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
                 ("solo"
                  ("violin" "Solo Violin" "Solo Vln." violin-i))
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

(defparameter *dur-all* (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
                              20 21 22 23 24 25 26 27 28))

(defparameter *dyn-all* (list 'ppp 'pp 'p 'mp 'mf 'f ));'ff 'fff))

(defun set-title (x)
  (setf (title *score*) x))

(defun set-subtitle (x)
  (setf (subtitle *score*) x))

(defun set-subsubtitle (x)
  (setf (subsubtitle *score*) x))

(defun pitches-from-root (root)
  (let ((root-pc (pc root))
        (root-oct (octave root)))
    (list root
          (make-instance 'pitch :pc (+ root-pc 7) :octave (1+ root-oct))
          (make-instance 'pitch :pc (+ root-pc 4) :octave (+ root-oct 2))
          (make-instance 'pitch :pc (+ root-pc 10) :octave (+ root-oct 2))
          (make-instance 'pitch :pc (+ root-pc 2) :octave (+ root-oct 3))
          (make-instance 'pitch :pc (+ root-pc 6) :octave (+ root-oct 3))
          (make-instance 'pitch :pc (+ root-pc 8) :octave (+ root-oct 3)))))

(defun minus-solo ()
  #'(lambda (label) (if (and (not (search "solo" label))
                             (able-to-play label)) 1 0)))

(defun all-instr ()
  #'(lambda (label) (if (able-to-play label) 1 0)))

(defun from-group (group-label)
  #'(lambda (label)
      (if (and (equal (search group-label label) 0) (able-to-play label)) 1 0)))

(defun from-list (list)
  #'(lambda (label)
      (if (and (member label list :test #'equal) (able-to-play label)) 1 0)))

(defparameter *line*
  (vector
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))
   (timed-dc (score-all-labels *score*) 2 (minus-solo))))

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
   (timed-dc (pitches-from-root (make-pitch '(0 . 1))))
   (timed-dc (pitches-from-root (make-pitch '(1 . 2))))
   (timed-dc (pitches-from-root (make-pitch '(2 . 1))))
   (timed-dc (pitches-from-root (make-pitch '(3 . 2))))
   (timed-dc (pitches-from-root (make-pitch '(4 . 1))))
   (timed-dc (pitches-from-root (make-pitch '(5 . 2))))
   (timed-dc (pitches-from-root (make-pitch '(6 . 1))))
   (timed-dc (pitches-from-root (make-pitch '(7 . 2))))
   (timed-dc (pitches-from-root (make-pitch '(8 . 1))))
   (timed-dc (pitches-from-root (make-pitch '(9 . 2))))
   (timed-dc (pitches-from-root (make-pitch '(10 . 1))))
   (timed-dc (pitches-from-root (make-pitch '(11 . 2))))))

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

(defun active-state (id bool)
  (setf (active (aref *gen-lines* id)) bool))

(defun set-dc (which id value)
  (setf (slot-value (aref *gen-lines* id) which) value)
  (case which
    (dynamic (setf (aref *dyn* id) value))
    (dur (setf (aref *dur* id) value))
    (pitch (setf (aref *pitch* id) value))
    (line (setf (aref *line* id) value))))

(defun set-prob-fun (which id f &optional (alpha 2))
  (case which
    (dynamic (setf (prob-fun (aref *dyn* id)) (wrap-dc-fun alpha f)))
    (dur (setf (prob-fun (aref *dur* id)) (wrap-dc-fun alpha f)))
    (pitch (setf (prob-fun (aref *pitch* id)) (wrap-dc-fun alpha f)))
    (line (setf (prob-fun (aref *line* id)) (wrap-dc-fun alpha f)))))
