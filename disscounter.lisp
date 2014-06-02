(defclass diss-counter ()
  ((elems
    :initarg :elems
    :accessor elems)
   (prob-fun
    :initarg :prob-fun
    :initform (lambda (x count) (declare (ignore x)) (* count count))
    :accessor prob-fun)))

(defmethod initialize-instance :after ((dc diss-counter) &key)
  (setf (elems dc) (mapcar #'(lambda (x) (list x 1 1)) (elems dc))))

(defun weighted-choice (dc)
  (let ((sum 0)
        (elems (elems dc)))
    (mapcar #'(lambda (e)
                 (incf sum (setf (caddr e)
                                 (funcall (prob-fun dc) (car e) (cadr e)))))
             elems)
    (let ((r (random sum))
          (chosen nil))
      (mapcar #'(lambda (e)
                  (decf r (caddr e))
                  (when (and (< r 0) (not chosen))
                    (setf chosen (car e))))
              elems)
      chosen)))

(defun next (dc)
  (let ((chosen (weighted-choice dc)))
    (mapcar #'(lambda (e)
                (if (equal (car e) chosen)
                    (setf (cadr e) 0)
                    (incf (cadr e))))
            (elems dc))
    chosen))
