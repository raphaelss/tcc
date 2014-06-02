(let ((curr-time 0))
  (defun timed-prob-fun (time-pos &optional (alpha 2) (extr-fun #'identity))
    (lambda (x count)
      (let ((time-diff (abs (- time-pos curr-time)))
            (value (funcall extr-fun x)))
        (* (expt count alpha) (exp (- (* value time-diff)))))))
  (defun set-curr-time (x)
    (setf curr-time x)))

(defun pitch-list-from-root (root)
  (let ((root-pc (pc root))
        (root-oct (octave root)))
    (list root
          (make-instance 'pitch :pc (+ root-pc 7) :octave (1+ root-oct))
          (make-instance 'pitch :pc (+ root-pc 4) :octave (+ root-oct 2))
          (make-instance 'pitch :pc (+ root-pc 10) :octave (+ root-oct 2))
          (make-instance 'pitch :pc (+ root-pc 2) :octave (+ root-oct 3))
          (make-instance 'pitch :pc (+ root-pc 5) :octave (+ root-oct 3))
          (make-instance 'pitch :pc (+ root-pc 8) :octave (+ root-oct 3)))))

(defun dur-extr-fun (x)
  (/ x 1000))

(defun pitch-extr-fun (x)
  (/ (pc x) 1000000))

(defun gen-line (time-pos base dur-elems root total-dur label
                 &key (offset 0) (dur-alpha 2) (pitch-alpha 2)
                   (dur-extr-fun #'dur-extr-fun)
                   (pitch-extr-fun #'pitch-extr-fun))
  (do* ((scaled-time-pos (* time-pos base))
        (dur-dc (make-instance 'diss-counter
                               :elems dur-elems
                               :prob-fun (timed-prob-fun scaled-time-pos
                                                         dur-alpha
                                                         dur-extr-fun)))
        (pitch-dc (make-instance 'diss-counter
                                 :elems (pitch-list-from-root root)
                                 :prob-fun (timed-prob-fun scaled-time-pos
                                                           pitch-alpha
                                                           pitch-extr-fun)))
        (time offset)
        (n-units (* base total-dur))
        (pc-line (make-instance 'poly-cont-line :base base :label label)))
       ((> time n-units) pc-line)
    (set-curr-time time)
    (let ((d (next dur-dc))
          (pitch (next pitch-dc)))
      (incf time d)
      (add-note pc-line (make-instance 'note :pitch pitch :mult d)))))

(let ((pc-lines nil)
      (total-dur)
      (dur-elems)
      (bar 4)
      (pitch-alpha 2)
      (dur-alpha 2)
      (dur-extr-fun #'dur-extr-fun)
      (pitch-extr-fun #'pitch-extr-fun))
  (defun total-dur (x)
    (setf total-dur x))
  (defun bar (x)
    (setf bar x))
  (defun dur-elems (x)
    (setf dur-elems x))
  (defun dur-alpha (x)
    (setf dur-alpha x))
  (defun pitch-alpha (x)
    (setf pitch-alpha x))
  (defun set-dur-extr-fun (x)
    (setf dur-extr-fun x))
  (defun set-pitch-extr-fun (x)
    (setf pitch-extr-fun x))
  (defun make-lines (specs)
    (setf pc-lines nil)
    (let ((i 1))
      (dolist (sp specs)
        (let ((time-pos (car sp))
              (root (make-pitch (cadr sp)))
              (base (caddr sp)))
          (push (gen-line time-pos base dur-elems root total-dur i
                          :dur-alpha dur-alpha
                          :pitch-alpha pitch-alpha
                          :dur-extr-fun dur-extr-fun
                          :pitch-extr-fun pitch-extr-fun)
                pc-lines)
          (incf i)))
      (setf pc-lines (nreverse pc-lines))))
  (defun output-lines (stream)
    (if (stringp stream)
        (with-open-file (file-stream
                         stream
                         :direction :output
                         :if-exists :supersede
                         :if-does-not-exist :create)
          (print-poly-cont file-stream bar pc-lines))
        (print-poly-cont stream bar pc-lines))))
