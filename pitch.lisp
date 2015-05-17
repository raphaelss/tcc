(in-package #:tcc)

(defvar *pc-name-vec* #("c" "des" "d" "ees" "e" "f" "ges"
                        "g" "aes" "a" "bes" "b"))

(defclass pitch ()
  ((pitch-class
    :initarg :pitch-class
    :initform 0
    :reader pitch-class
    :type fixnum)
   (octave
    :initarg :octave
    :initform 4
    :accessor octave
    :type fixnum)))

(defmethod initialize-instance :after ((pitch pitch) &key)
  (with-slots (pitch-class octave) pitch
    (setf octave (+ octave
                    (truncate pitch-class 12)
                    (if (< pitch-class 0) -1 0))
          pitch-class (mod pitch-class 12))))

(defun make-pitch (pc &optional (oct 4))
  (make-instance 'pitch :pitch-class pc :octave oct))

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

(defun pitch= (p1 p2)
  (and (= (pitch-class p1) (pitch-class p2))
       (= (octave p1) (octave p2))))

(defun pitch<= (p1 p2)
  (or (pitch< p1 p2) (pitch= p1 p2)))

(defun pitch>= (p1 p2)
  (or (pitch> p1 p2) (pitch= p1 p2)))

(defun pitch/= (p1 p2)
  (not (pitch= p1 p2)))

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
