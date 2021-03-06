(in-package #:tcc)

(defun start-score ()
  (setf *score* (make-score
                 :title "" :subtitle "" :subsubtitle ""
                 :spec
                 '(("woodwind"
                    ("piccolo" "Piccolo" "Picc." piccolo)
                    ("flutei" "Flute I" "Fl. I" flute)
                    ("fluteii" "Flute II" "Fl. II" flute)
                    ("oboei" "Oboe I" "Ob. I" oboe)
                    ("oboeii" "Oboe II" "Ob. II" oboe)
                    ("enghorn" "Eng. Horn" "E. H." eng-horn)
                    ("clarineti" "Clarinet Bb I" "Cl. Bb I" clarinet)
                    ("clarinetii" "Clarinet Bb II" "Cl. Bb II" clarinet)
                    ("bassclarinet" "Bass Clarinet" "Bass Cl." bass-clarinet)
                    ("bassooni" "Bassoon I" "Bn. I" bassoon)
                    ("bassoonii" "Bassoon II" "Bn. II" bassoon)
                    ("contrabassoon" "Contrabassoon" "Cbsn." contrabassoon))
                   ("brass"
                    ("horni" "French Horn I" "F. H. I" f-horn)
                    ("hornii" "French Horn II" "F. H. II" f-horn)
                    ("horniii" "French Horn III" "F. H. III" f-horn)
                    ("horniv" "French Horn IV" "F. H. IV" f-horn)
                    ("trumpeti" "Trumpet I" "Tpt. I" trumpet)
                    ("trumpetii" "Trumpet II" "Tpt. II" trumpet)
                    ("trumpetiii" "Trumpet III" "Tpt. III" trumpet)
                    ("trombonei" "Trombone I" "Tbn. I" trombone)
                    ("tromboneii" "Trombone II" "Tbn. II" trombone)
                    ("basstrombone" "Bass Trombone" "Bass Tbn." trombone)
                    ("tuba" "Tuba" "Tba." tuba))
                   ("solo"
                    ("si" "Solo Violin" "Solo Vln." violin-i)
                    ("sii" "Solo Violin" "Solo Vln." violin-i))
;                    ("siii" "Solo Violin" "Solo Vln." violin-i)
;                    ("siv" "Solo Violin" "Solo Vln." violin-i))
;                    ("sv" "Solo Violin" "Solo Vln." violin-i)
;                    ("svi" "Solo Violin" "Solo Vln." violin-i))
                   ("string"
                    ("violinia" "Violin Ia" "Vln. Ia" violin-i)
                    ("violinib" "Violin Ib" "Vln. Ib" violin-i)
                    ("violiniia" "Violin IIa" "Vln. IIa" violin-ii)
                    ("violiniib" "Violin IIb" "Vln. IIb" violin-ii)
                    ("violaa" "Viola I" "Vla. I" viola)
                    ("violab" "Viola II" "Vla. II" viola)
                    ("celloa" "Cello I" "Vc. I" cello)
                    ("cellob" "Cello II" "Vc. II" cello)
                    ("bass" "Double Bass" "Db." bass))))))

(start-score)

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
  (let ((root-pc (pitch-class root))
        (root-oct (octave root)))
    (list root
          (make-pitch (+ root-pc 7) (1+ root-oct))
          (make-pitch (+ root-pc 4) (+ root-oct 2))
          (make-pitch (+ root-pc 10) (+ root-oct 2))
          (make-pitch (+ root-pc 2) (+ root-oct 3))
          (make-pitch (+ root-pc 6) (+ root-oct 3))
          (make-pitch (+ root-pc 8) (+ root-oct 3)))))

(defun minus-solo ()
  #'(lambda (label) (if (and (not (search "solo" label))
                             (able-to-play label)) 1 0)))

(defun all-instr ()
  #'(lambda (label) (if (able-to-play label) 1 0)))

(defun instr-from-group (&rest list)
 #'(lambda (label)
     (if (some #'(lambda (group-label)
                   (and (equal (search group-label label) 0)
                        (able-to-play label))) list) 1 0)))

(defun instr-from-list (list)
  #'(lambda (label)
      (if (and (member label list :test #'equal) (able-to-play label)) 1 0)))

(defun from-list (list)
  #'(lambda (x)
      (if (member x list :test #'equal) 1 0)))

(defun decay-pos (pos n fun &key (list nil))
  (if list
      #'(lambda (x)
          (if (member x list :test #'equal)
              (* n (exp (- (* (funcall fun x) (abs (- *curr-time* pos))))))
              0))
      #'(lambda (x)
          (* n (exp (- (* (funcall fun x) (abs (- *curr-time* pos)))))))))

(defun map-range (x left-a left-b right-a right-b)
  (+ right-a (/ (* (- x left-a) (- right-b right-a)) (- left-b left-a))))

(defun interpolation (list1 list2 init end)
  #'(lambda (x)
      (let ((member1 (member x list1 :test #'equal))
            (member2 (member x list2 :test #'equal)))
        (cond ((and member1 member2) 1)
              (member1 (map-range *curr-time* init end 1 0))
              (member2 (map-range *curr-time* init end 0 1))
              (t 0)))))

(defvar *line*)
(defvar *dyn*)
(defvar *dur*)
(defvar *pitch*)
(defvar *chord-n*)
(defvar *rest-n*)
(defvar *gen-lines*)
(defvar *gen-line-list*)

(defun create-gen-lines ()
  (setf *line*
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

  (setf *dyn*
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

  (setf *chord-n* (vector 1 1 1 1 1 1 1 1 1 1 1 1))

  (setf *rest-n* (vector nil nil nil nil nil nil nil nil nil nil nil nil))

  (setf *dur*
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

  (setf *pitch*
        (vector
         (timed-dc (pitches-from-root (make-pitch 0 1)))
         (timed-dc (pitches-from-root (make-pitch 1 2)))
         (timed-dc (pitches-from-root (make-pitch 2 1)))
         (timed-dc (pitches-from-root (make-pitch 3 2)))
         (timed-dc (pitches-from-root (make-pitch 4 1)))
         (timed-dc (pitches-from-root (make-pitch 5 2)))
         (timed-dc (pitches-from-root (make-pitch 6 1)))
         (timed-dc (pitches-from-root (make-pitch 7 2)))
         (timed-dc (pitches-from-root (make-pitch 8 1)))
         (timed-dc (pitches-from-root (make-pitch 9 2)))
         (timed-dc (pitches-from-root (make-pitch 10 1)))
         (timed-dc (pitches-from-root (make-pitch 11 2)))))

  (setf *gen-lines* (make-array 12))
  (setf *gen-line-list*
        (let ((result nil))
          (dotimes (i 12 result)
            (let ((gen-line (make-instance 'gen-line :base (+ (mod i 6) 2)
                                           :dur (aref *dur* i)
                                           :line (aref *line* i)
                                           :chord-n (aref *chord-n* i)
                                           :rest-n nil
                                           :rest-count nil
                                           :dynamic (aref *dyn* i)
                                           :pitch (aref *pitch* i))))
              (setf (aref *gen-lines* i) gen-line)
              (push gen-line result)
              result)))))

(create-gen-lines)

(defun clear ()
  (start-score)
  (setf *curr-time* 0)
  (create-gen-lines))

(defun active-state (id bool)
  (setf (active (aref *gen-lines* id)) bool))

(defun active-list (&rest list)
  (dotimes (i 12)
    (active-state i (member i list :test #'=))))

(defun set-dc (which id value)
  (setf (slot-value (aref *gen-lines* id) which) value)
  (case which
    (rest-n (setf (aref *rest-n* id) value)
            (setf (rest-count (aref *gen-lines* id)) nil))
    (chord-n (setf (aref *chord-n* id) value))
    (dynamic (setf (aref *dyn* id) value))
    (dur (setf (aref *dur* id) value))
    (pitch (setf (aref *pitch* id) value))
    (line (setf (aref *line* id) value))))

(defun set-prob-fun (which id f &optional (alpha 2))
  (case which
    (rest-n (setf (diss-counter::prob-fun (aref *chord-n* id))
                  (wrap-dc-fun alpha f)))
    (chord-n (setf (diss-counter::prob-fun (aref *chord-n* id))
                   (wrap-dc-fun alpha f)))
    (dynamic (setf (diss-counter::prob-fun (aref *dyn* id))
                   (wrap-dc-fun alpha f)))
    (dur (setf (diss-counter::prob-fun (aref *dur* id))
               (wrap-dc-fun alpha f)))
    (pitch (setf (diss-counter::prob-fun (aref *pitch* id))
                 (wrap-dc-fun alpha f)))
    (line (setf (diss-counter::prob-fun (aref *line* id))
                (wrap-dc-fun alpha f)))))
