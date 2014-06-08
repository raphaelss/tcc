(defclass gen-line ()
  ((pitch
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
    :accessor in-tuplet)))

(defun abs-time (gen-line)
  (+ (beat-n gen-line) (/ (in-tuplet gen-line) (base gen-line))))

(defun next-gen-line (gen-lines)
  (reduce #'(lambda (x y) (if (<= (abs-time x) (abs-time y)) x y)) gen-lines))

(defun step-dc (obj)
  (if (eq (type-of obj) 'diss-counter)
      (next obj)
      obj))

(defun gen-line-step (gen-line)
  (let* ((pitch (step-dc (pitch gen-line)))
         (dur (step-dc (dur gen-line)))
         (dyn (and pitch (step-dc (dynamic gen-line))))
         (chord (and pitch (step-dc (chord gen-line))))
         (line (step-dc (line gen-line)))
         (base (base gen-line))
         (in-tuplet (in-tuplet gen-line))
         (in-tuplet-sum (+ in-tuplet dur))
         (beat-n (beat-n gen-line))
         (note (make-instance
                'note :pitch (if (and pitch (> chord 1))
                                 (list pitch (step-dc (pitch gen-line)))
                                 pitch)
                :dynamic dyn :base base :mult dur)))
    (if (>= in-tuplet-sum base)
        (setf (beat-n gen-line) (+ beat-n (truncate dur base) 1)
              (in-tuplet gen-line) (- in-tuplet-sum base))
        (setf (beat-n gen-line) (+ beat-n (truncate dur base))
              (in-tuplet gen-line) in-tuplet-sum))
    (score-apply *score* line #'add-note note beat-n in-tuplet)))

(defun run-until (gen-lines until)
  (loop while (every #'(lambda (x) (>= (beat-n x) until)) gen-lines) do
       (let ((current (next-gen-line gen-lines)))
         (gen-line-step current))))

(defun make-gen-line ())
