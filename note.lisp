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
   (dynamic
    :initarg :dynamic
    :initform 'mf
    :accessor dynamic)
   (mult
    :initarg :mult
    :initform 1
    :accessor mult)
   (base
    :initarg :base
    :initform 2
    :accessor base)))

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

(defun pitch< (p1 p2)
  (let ((o1 (octave p1))
        (o2 (octave p2)))
    (if (= o1 o2)
        (< (pc p1) (pc p2))
        (< o1 o2))))

(defun pitch> (p1 p2)
  (let ((o1 (octave p1))
        (o2 (octave p2)))
    (if (= o1 o2)
        (> (pc p1) (pc p2))
        (> o1 o2))))

(defun pitch<= (p1 p2)
  (let ((o1 (octave p1))
        (o2 (octave p2)))
    (if (= o1 o2)
        (<= (pc p1) (pc p2))
        (< o1 o2))))

(defun pitch>= (p1 p2)
  (let ((o1 (octave p1))
        (o2 (octave p2)))
    (if (= o1 o2)
        (>= (pc p1) (pc p2))
        (> o1 o2))))

(defun pitch= (p1 p2)
  (and (= (pc p1) (pc p2)) (= (octave p1) (octave p2))))

(defun pitch/= (p1 p2)
  (or (/= (pc p1) (pc p2)) (/= (octave p1) (octave p2))))

(defun pitch-in-range (p p1 p2)
  (or (and (pitch>= p p1) (pitch<= p p2))
      (and (pitch>= p p2) (pitch<= p p1))))

(defun pitch-repr (x)
  (let ((pc-name (aref *pc-name-vec* (pc x)))
        (oct (octave x)))
    (format nil "~A~A" pc-name
            (if (> oct 3)
                (make-string (- oct 3)
                             :initial-element #\')
                (make-string (- 3 oct)
                             :initial-element #\,)))))

(defun gen-pitch-repr (x)
  (cond ((consp x)
         (format nil "<~{~a~^ ~}>" (mapcar #'pitch-repr x)))
        ((eq (type-of x) 'pitch)
         (pitch-repr x))
        (t "r")))

(defun dynamic-repr (dyn)
  (case dyn
    (ppp "\\ppp")
    (pp "\\pp")
    (p "\\p")
    (mp "\\mp")
    (mf "\\mf")
    (f "\\f")
    (ff "\\ff")
    (fff "\\fff")
    (t "")))

(defun make-rest (base mult)
  (make-instance 'note :pitch nil :dynamic nil
                 :base base :mult mult))

(defun write-figure-in-tuplet (stream pc dyn base mult)
  (format stream (aref (aref *mult-tuplet* (- base 2)) (- mult 1))
          pc (dynamic-repr dyn) (if (equal pc "r") 1 0)))

(defun write-figure (stream pc dyn base mult)
  (format stream (aref (aref *mult-fig* (- base 2)) (- mult 1))
          pc (dynamic-repr dyn) (if (equal pc "r") 1 0)))

(defun calc-tuplet-left (base x)
  (mod (- base (mod x base)) base))

(defun print-in-tuplet (stream pc dyn base mult bar-left tuplet-left)
  (cond ((< mult tuplet-left)
         (write-figure-in-tuplet stream pc dyn base mult)
         (values 0 bar-left (- tuplet-left mult) nil))
        ((= mult tuplet-left)
         (write-figure-in-tuplet stream pc dyn base mult)
         (values 0 bar-left 0 '(close-tuplet)))
        (t
         (write-figure-in-tuplet stream pc dyn base tuplet-left)
         (values (- mult tuplet-left) bar-left 0 '(tie close-tuplet)))))

(defun print-figure (stream pc dyn base mult bar-left)
  (let ((mult-left (* base bar-left)))
    (cond ((< mult mult-left)
           (write-figure stream pc dyn base mult)
           (setf mult-left (- mult-left mult))
           (values 0 (truncate mult-left base) (mod mult-left base) nil))
          ((= mult mult-left)
           (write-figure stream pc dyn base mult)
           (values 0 0 0 nil))
          (t
           (write-figure stream pc dyn base mult-left)
           (values (- mult mult-left) 0 0 '(tie))))))

(defun print-note-impl (stream pc dyn base mult bar-left tuplet-left)
  (do ((state nil nil)
       (dyn-m dyn)
       (mult-m mult)
       (bar-left-m bar-left (if (= bar-left-m tuplet-left-m 0) 4 bar-left-m))
       (tuplet-left-m tuplet-left))
      ((= mult-m 0) (values bar-left-m tuplet-left-m))
    (setf (values mult-m bar-left-m tuplet-left-m state)
          (cond ((= tuplet-left-m 0)
                 (print-figure stream pc dyn-m base mult-m bar-left-m))
                (t
                 (print-in-tuplet stream pc dyn-m base mult-m
                                  bar-left-m tuplet-left-m))))
    (dolist (s state)
      (case s
        (tie (if (not (equal pc "r")) (format stream "~~")))
        (close-tuplet (if (/= base 2 4) (format stream "}")))))
    (format stream " ")
    (setf dyn-m nil)))

(defun print-note (stream note bar-left tuplet-left)
  (let ((base (base note)))
    (print-note-impl stream (gen-pitch-repr (pitch note))
                     (dynamic note) base (mult note)
                     bar-left tuplet-left)))
