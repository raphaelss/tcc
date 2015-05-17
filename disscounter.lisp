o(defpackage #:diss-counter
  (:use :cl)
  (:export #:make #:next))

(in-package #:diss-counter)

(defclass diss-counter ()
  ((elems
    :initarg :elems
    :accessor elems)
   (prob-fun
    :initarg :prob-fun
    :accessor prob-fun)
   (prob-sum
    :initarg :prob-sum
    :accessor prob-sum)))

(defstruct entry
  elem
  count
  prob)

(defun power-fun (x count)
  (declare (ignore x))
  (* count count))

(defun make (elems &key (prob-fun #'power-fun) (initial-count 1))
  (let* ((size (length elems))
         (table (make-array size :initial-contents elems))
         (sum 0))
    (dotimes (i size)
      (let* ((x (svref table i))
             (prob (funcall prob-fun x 1)))
        (incf sum prob)
        (setf (svref table i)
              (make-entry :elem x :count initial-count :prob prob))))
    (make-instance 'diss-counter :elems table :prob-fun prob-fun
                   :prob-sum sum)))

(defun entry-increase (entry f)
  (incf (entry-count entry))
  (setf (entry-prob entry)
        (funcall f (entry-elem entry) (entry-count entry))))

(defun entry-zero (entry f)
  (setf (entry-count entry) 0
        (entry-prob entry)
        (funcall f (entry-elem entry) 0)))

(defun next (dc)
  (with-slots (elems prob-fun prob-sum) dc
    (let ((r (random prob-sum))
          (chosen nil))
      (setf prob-sum 0)
      (dotimes (i (length elems))
        (let ((entry (svref elems i)))
          (incf prob-sum
                (cond
                  (chosen
                   (entry-increase entry prob-fun))
                  ((< (decf r (entry-prob entry)) 0)
                   (setf chosen (entry-elem entry))
                   (entry-zero entry prob-fun))
                  (t
                   (entry-increase entry prob-fun))))))
      chosen)))
