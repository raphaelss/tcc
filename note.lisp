(defparameter *max-mult* #((* 4 2) (* 4 3) (* 4 4) (* 4 5) (* 4 6) (* 4 7)))
(defparameter *pc-name-vec* #("c" "des" "d" "ees" "e" "f" "ges"
                        "g" "aes" "a" "bes" "b"))
(defparameter *mult-tuplet* #(#("~a8") ;2
                              #("~a8" "~a4") ;3
                              #("~a16" "~a8" "~a8.") ;4
                              #("~a16" "~a8" "~a8." "~a4") ;5
                              #("~a16" "~a8" "~a8." "~a4" "~a8.~~ ~:*~a8") ;6!!!
                              #("~a16" "~a8" "~a8." "~a4"
                                "~a4~~ ~:*~a16" "~a4."))) ;7
(defparameter *mult-fig* #(#("~a8"  ;2.1
                             "~a4"  ;.2
                             "~a4." ;.3
                             "~a2"  ;.4
                             "~a2~~ ~:*~a8" ;.5
                             "~a2." ;.6
                             "~a2.~~ ~:*~a8" ;.7
                             "~a1") ;.8
                           #("\\times 2/3 {~a8" ;3.1
                             "\\times 2/3 {~a4" ;.2
                             "~a4" ;.3
                             "~a4~~ \\times 2/3 {~:*~a8" ;.4
                             "~a4~~ \\times 2/3 {~:*~a4" ;.5
                             "~a2" ;.6
                             "~a2~~ \\times 2/3 {~:*~a8" ;.7
                             "~a2~~ \\times 2/3 {~:*~a4" ;.8
                             "~a2." ;.9
                             "~a2.~~ \\times 2/3 {~:*~a8" ;.10
                             "~a2.~~ \\times 2/3 {~:*~a4" ;.11
                             "~a1") ;12
                           #("~a16" ;4.1
                             "~a8" ;.2
                             "~a8." ;.3
                             "~a4" ;.4
                             "~a4~~ ~:*~a16" ;.5
                             "~a4." ;.6
                             "~a4~~ ~:*~a8." ;.7
                             "~a2" ;.8
                             "~a2~~ ~:*~a16" ;.9
                             "~a2~~ ~:*~a8" ;.10
                             "~a2~~ ~:*~a8." ;.11
                             "~a2." ;.12
                             "~a2~~ ~:*~a16" ;.13
                             "~a2~~ ~:*~a8" ;.14
                             "~a2~~ ~:*~a8." ;.15
                             "~a1") ;.16
                           #("\\times 4/5 {~a16" ;5.1
                             "\\times 4/5 {~a8" ;.2
                             "\\times 4/5 {~a8." ;.3
                             "\\times 4/5 {~a4" ;.4
                             "~a4" ;.5
                             "~a4~~ \\times 4/5 {~:*~a16" ;.6
                             "~a4~~ \\times 4/5 {~:*~a8" ;.7
                             "~a4~~ \\times 4/5 {~:*~a8." ;.8
                             "~a4~~ \\times 4/5 {~:*~a4" ;.9
                             "~a2" ;.10
                             "~a2~~ \\times 4/5 {~:*~a16" ;.11
                             "~a2~~ \\times 4/5 {~:*~a8" ;.12
                             "~a2~~ \\times 4/5 {~:*~a8." ;.13
                             "~a2~~ \\times 4/5 {~:*~a4" ;.14
                             "~a2." ;.15
                             "~a2.~~ \\times 4/5 {~:*~a16" ;.16
                             "~a2.~~ \\times 4/5 {~:*~a8" ;.17
                             "~a2.~~ \\times 4/5 {~:*~a8." ;.18
                             "~a2.~~ \\times 4/5 {~:*~a4" ;.19
                             "a1") ;.20
                           #("\\times 4/6 {~a16" ;6.1
                             "\\times 4/6 {~a8" ;.2
                             "\\times 4/6 {~a8." ;.3
                             "\\times 4/6 {~a4" ;.4
                             "\\times 4/6 {~a8.~~ ~:*~a8" ;.5!!!
                             "~a4" ;.6
                             "~a4~~ \\times 4/6 {~:*~a16" ;.7
                             "~a4~~ \\times 4/6 {~:*~a8" ;.8
                             "~a4~~ \\times 4/6 {~:*~a8." ;.9
                             "~a4~~ \\times 4/6 {~:*~a4" ;.10
                             "~a4~~ \\times 4/6 {~:*~a8.~~ ~:*~a8" ;.11
                             "~a2" ;.12
                             "~a2~~ \\times 4/6 {~:*~a16" ;.13
                             "~a2~~ \\times 4/6 {~:*~a8" ;.14
                             "~a2~~ \\times 4/6 {~:*~a8." ;.15
                             "~a2~~ \\times 4/6 {~:*~a4" ;.16
                             "~a2~~ \\times 4/6 {~:*~a8.~~ ~:*~a8" ;.17
                             "~a2." ;.18
                             "~a2.~~ \\times 4/6 {~:*~a16" ;.19
                             "~a2.~~ \\times 4/6 {~:*~a8" ;.20
                             "~a2.~~ \\times 4/6 {~:*~a8." ;.21
                             "~a2.~~ \\times 4/6 {~:*~a4" ;.22
                             "~a2.~~ \\times 4/6 {~:*~a8.~~ ~:*~a8" ;.23
                             "~a1") ;.24
                           #("\\times 4/7 {~a16" ;7.1
                             "\\times 4/7 {~a8" ;.2
                             "\\times 4/7 {~a8." ;.3
                             "\\times 4/7 {~a4" ;.4
                             "\\times 4/7 {~a4~~ ~:*~a16" ;.5
                             "\\times 4/7 {~a4." ;.6
                             "~a4" ;.7
                             "~a4~~ \\times 4/7 {~:*~a16" ;.8
                             "~a4~~ \\times 4/7 {~:*~a8" ;.9
                             "~a4~~ \\times 4/7 {~:*~a8." ;.10
                             "~a4~~ \\times 4/7 {~:*~a4" ;.11
                             "~a4~~ \\times 4/7 {~:*~a4~~ ~:*~a16" ;.12
                             "~a4~~ \\times 4/7 {~:*~a4." ;.13
                             "~a2" ;.14
                             "~a2~~ \\times 4/7 {~:*~a16" ;.15
                             "~a2~~ \\times 4/7 {~:*~a8" ;.16
                             "~a2~~ \\times 4/7 {~:*~a8." ;.17
                             "~a2~~ \\times 4/7 {~:*~a4" ;.18
                             "~a2~~ \\times 4/7 {~:*~a4~~ ~:*~a16" ;.19
                             "~a2~~ \\times 4/7 {~:*~a4." ;.20
                             "~a2." ;.21
                             "~a2.~~ \\times 4/7 {~:*~a16" ;.22
                             "~a2.~~ \\times 4/7 {~:*~a8" ;.23
                             "~a2.~~ \\times 4/7 {~:*~a8." ;.24
                             "~a2.~~ \\times 4/7 {~:*~a4" ;.25
                             "~a2.~~ \\times 4/7 {~:*~a4~~ ~:*~a16" ;.26
                             "~a2.~~ \\times 4/7 {~:*~a4." ;.27
                            "a1"))) ;.28

(defclass pitch ()
  ((pc
    :initarg :pc
    :initform 0
    :accessor pc)
   (octave
    :initarg :octave
    :initform 4
    :accessor octave)))

(defclass note ()
  ((pitch
    :initarg :pitch
    :initform (make-instance 'pitch)
    :accessor pitch)
   (mult
    :initarg :mult
    :initform 1
    :accessor mult)))

(defmethod initialize-instance :after ((p pitch) &key)
  (let ((pc (pc p)))
    (setf (pc p) (mod pc 12))
    (loop with i = pc while (>= i 12) do
         (incf (octave p))
         (decf i 12))
    (loop with i = pc while (< i 0) do
         (decf (octave p))
         (incf i 12))))

(defun make-pitch (pc-oct)
  (let ((pc (car pc-oct))
        (oct (cdr pc-oct)))
    (make-instance 'pitch :pc pc :octave oct)))

(defun pitch-repr (pitches)
  (if pitches
      (format nil "<~{~a~^ ~}>"
              (mapcar #'(lambda (x)
                          (let ((pc-name (aref *pc-name-vec* (pc x)))
                                (oct (octave x)))
                            (format nil "~A~A" pc-name
                                    (if (> oct 3)
                                        (make-string (- oct 3)
                                                     :initial-element #\')
                                        (make-string (- 3 oct)
                                                     :initial-element #\,)))))
              pitches))
      "r"))

(defun print-note-tuplet (stream pc base mult)
  (format stream (aref (aref *mult-tuplet* (- base 2)) (- mult 1)) pc))

(defun print-note-figure (stream pc base mult)
  (format stream (aref (aref *mult-fig* (- base 2)) (- mult 1)) pc))

(defun calc-tuplet-left (base x)
  (rem (- base (mod x base)) base))

(defun print-note (stream note base bar bar-left tuplet-left)
  (do ((pc (pitch-repr (pitch note)))
       (mult (mult note))
       (new-bar-left bar-left)
       (new-tuplet-left tuplet-left))
      ((= mult 0) (values new-bar-left new-tuplet-left))
    (if (= new-tuplet-left 0)
        (cond ((< mult new-bar-left)
               (print-note-figure stream pc base mult)
               (setf new-bar-left (- new-bar-left mult)
                     new-tuplet-left (calc-tuplet-left base mult)
                     mult 0))
              ((= mult new-bar-left)
               (print-note-figure stream pc base mult)
               (setf mult 0
                     new-bar-left bar
                     new-tuplet-left 0))
              (t
               (print-note-figure stream pc base new-bar-left)
               (format stream "~~ ")
               (setf mult (- mult new-bar-left)
                     new-bar-left bar
                     new-tuplet-left 0)))
        (cond ((< mult new-tuplet-left)
               (print-note-tuplet stream pc base mult)
               (setf new-tuplet-left (- new-tuplet-left mult)
                     new-bar-left (- new-bar-left mult)
                     mult 0))
              ((= mult new-tuplet-left)
               (print-note-tuplet stream pc base new-tuplet-left)
               (if (/= base 2 4)
                   (format stream "}"))
               (setf new-bar-left (- new-bar-left new-tuplet-left)
                     mult 0
                     new-tuplet-left 0)
               (if (= new-bar-left 0)
                   (setf new-bar-left bar)))
              (t
               (print-note-tuplet stream pc base new-tuplet-left)
               (format stream "~~")
               (if (/= base 2 4)
                   (format stream "} ")
                   (format stream " "))
               (setf mult (- mult new-tuplet-left)
                     new-bar-left (- new-bar-left new-tuplet-left)
                     new-tuplet-left 0)
               (if (= new-bar-left 0)
                   (setf new-bar-left bar)))))))
