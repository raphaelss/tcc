(in-package #:tcc)

(defvar *score*)
(defparameter *curr-time* 0)
(defvar *curr-beat-n*)
(defvar *curr-in-tuplet*)
(defvar *curr-note*)

(defclass gen-line ()
  ((active
    :initarg :active
    :initform t
    :accessor active)
   (rest-n
    :initarg :rest-n
    :initform nil
    :accessor rest-n)
   (rest-count
    :initarg :rest-count
    :initform nil
    :accessor rest-count)
   (pitch
    :initarg :pitch
    :initform (make-pitch (cons 0 4))
    :accessor pitch)
   (dur
    :initarg :dur
    :initform 1
    :accessor dur)
   (dynamic
    :initarg :dynamic
    :initform nil
    :accessor dynamic)
   (chord-n
    :initarg :chord-n
    :initform 1
    :accessor chord-n)
   (line
    :initarg :line
    :accessor line)
   (base
    :initarg :base
    :initform 2
    :accessor base)
   (beat-n
    :initarg :beat-n
    :initform 0
    :accessor beat-n)
   (in-tuplet
    :initarg :in-tuplet
    :initform 0
    :accessor in-tuplet)
   (octave
    :initarg :octave
    :initform nil
    :accessor octave)))

(defun abs-time (gen-line)
  (+ (beat-n gen-line) (/ (in-tuplet gen-line) (base gen-line))))

(defun next-gen-line (gen-lines)
  (reduce #'(lambda (x y) (if (<= (abs-time x) (abs-time y)) x y)) gen-lines))

(defun update-curr-time (gen-line)
  (setf *curr-time* (+ (beat-n gen-line) (/ (in-tuplet gen-line)
                                            (base gen-line)))))

(defun able-to-play (label)
  (score-apply *score* label #'line-able-note *curr-note*
               *curr-beat-n* *curr-in-tuplet*))

(defun step-dc (obj)
  (if (eq (type-of obj) 'diss-counter::diss-counter)
      (diss-counter:next obj)
      obj))

(defun gen-line-step (gen-line)
  (update-curr-time gen-line)
  (let* ((base (base gen-line))
         (dur (step-dc (dur gen-line)))
         (beat-n (beat-n gen-line))
         (in-tuplet (in-tuplet gen-line))
         (in-tuplet-sum (+ in-tuplet (mod dur base))))
    (if (and (not (rest-count gen-line)) (rest-n gen-line))
        (setf (rest-count gen-line) (step-dc (rest-n gen-line))))
    (setf *curr-beat-n* beat-n *curr-in-tuplet* in-tuplet)
    (if (not (equal (rest-count gen-line) 0))
        (let ((dyn (step-dc (dynamic gen-line)))
              (chord-n (step-dc (chord-n gen-line)))
              (pitch (step-dc (pitch gen-line)))
              (line)
              (note))
          (dotimes (i chord-n)
            (restart-case
                (progn
                  (setf note (make-instance
                              'note :pitch pitch :dynamic dyn
                              :base base :mult dur))
                  (setf *curr-note* note)
                  (setf line (step-dc (line gen-line)))
                  (setf note (change-octave
                              note (main-octave (instrument
                                                 (score-get-line
                                                  *score* line)))))
                  (score-apply *score* line #'add-note note beat-n in-tuplet))
              (skip-note () nil)))
          (if (rest-count gen-line) (decf (rest-count gen-line))))
        (setf (rest-count gen-line) (step-dc (rest-n gen-line))))
    (if (>= in-tuplet-sum base)
        (setf (beat-n gen-line) (+ beat-n (truncate dur base) 1)
              (in-tuplet gen-line) (- in-tuplet-sum base))
        (setf (beat-n gen-line) (+ beat-n (truncate dur base))
              (in-tuplet gen-line) in-tuplet-sum))))

(defun run-until (gen-lines until)
  (loop while (some #'(lambda (x) (< (beat-n x) until)) gen-lines) do
       (let ((current (next-gen-line gen-lines)))
         (if (active current)
             (gen-line-step current)
             (setf (beat-n current) until (in-tuplet current) 0)))))

(defun wrap-dc-fun (&optional (alpha 2) (fun (constantly 1)))
  #'(lambda (x count) (* (expt count alpha) (funcall fun x))))

(defun timed-dc (elems &optional (alpha 2) (fun (constantly 1)))
  (diss-counter:make elems :prob-fun (wrap-dc-fun alpha fun)))

(defun gen-line (&key base pitch dynamic duration chord-n line)
  (make-instance 'gen-line :base base :pitch pitch :dynamic dynamic
                 :duration duration :chord-n chord-n :line line))
