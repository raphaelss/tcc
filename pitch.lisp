(in-package #:tcc)

(defclass pitch ()
  ((pitch-class
    :initarg :pitch-class
    :initform 0
    :accessor pitch-class)
   (octave
    :initarg :octave
    :initform 4
    :accessor octave)))

(defun make-pitch (pc &optional (oct 4))
  (make-instance 'pitch :pitch-class (mod pc 12)
                 :octave (+ oct (truncate pc 12) (if (< pc 0) -1 0))))

(defun pitch< (p1 p2)
  (let ((o1 (octave p1))
        (o2 (octave p2)))
    (if (= o1 o2)
        (< (pitch-class p1) (pitch-class p2))
        (< o1 o2))))

(defun pitch> (p1 p2)
  (let ((o1 (octave p1))
        (o2 (octave p2)))
    (if (= o1 o2)
        (> (pitch-class p1) (pitch-class p2))
        (> o1 o2))))

(defun pitch<= (p1 p2)
  (let ((o1 (octave p1))
        (o2 (octave p2)))
    (if (= o1 o2)
        (<= (pitch-class p1) (pitch-class p2))
        (< o1 o2))))

(defun pitch>= (p1 p2)
  (let ((o1 (octave p1))
        (o2 (octave p2)))
    (if (= o1 o2)
        (>= (pitch-class p1) (pitch-class p2))
        (> o1 o2))))

(defun pitch= (p1 p2)
  (and (= (pitch-class p1) (pitch-class p2))
       (= (octave p1) (octave p2))))

(defun pitch/= (p1 p2)
  (or (/= (pitch-class p1) (pitch-class p2))
      (/= (octave p1) (octave p2))))

(defun pitch-in-range (p p1 p2)
  (or (and (pitch>= p p1) (pitch<= p p2))
      (and (pitch>= p p2) (pitch<= p p1))))

(defun pitch-repr (x)
  (let ((pc-name (aref *pc-name-vec* (pitch-class x)))
        (oct (octave x)))
    (format nil "~A~A" pc-name
            (if (> oct 3)
                (make-string (- oct 3)
                             :initial-element #\')
                (make-string (- 3 oct)
                             :initial-element #\,)))))
