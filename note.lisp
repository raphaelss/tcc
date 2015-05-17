(in-package #:tcc)

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

(defun change-octave (note oct)
  (let ((pc (pitch-class (pitch note))))
    (make-instance
     'note :pitch (make-instance 'pitch :pc pc :octave oct)
     :mult (mult note) :base (base note)
     :dynamic (dynamic note))))

(defun write-figure-in-tuplet (stream pc dyn base mult)
  (format stream (aref (aref *mult-tuplet* (- base 2)) (- mult 1))
          pc (dynamic-repr dyn) (if (equal pc "r") 1 0)))

(defun write-figure (stream pc dyn base mult)
  (let ((to-print (format nil (aref (aref *mult-fig* (- base 2)) (- mult 1))
                          pc (dynamic-repr dyn) (if (equal pc "r") 1 0))))
    (if (equal to-print "r1")
        (format stream "R1")
        (format stream "~a" to-print))))

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
