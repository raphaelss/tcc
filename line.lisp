(defclass line ()
  ((label
    :initarg :label
    :accessor label)
   (name
    :initarg :name
    :accessor name)
   (short-name
    :initarg :short-name
    :accessor short-name)
   (instrument
    :initarg :instrument
    :accessor instrument)
   (beat-n
    :initarg :beat-n
    :initform 0
    :accessor beat-n)
   (in-tuplet
    :initarg :in-tuplet
    :initform 0
    :accessor in-tuplet)
   (notes
    :initarg :notes
    :initform ()
    :accessor notes)))

(defun last-base (line)
  (let ((notes (notes line)))
    (if notes
        (base (car notes))
        2)))

(defun last-beat (line)
  (let ((last-beat (* (floor (/ (+ (beat-n line) 3) 4)) 4)))
    (if (and (= last-beat (beat-n line)) (/= (in-tuplet line) 0))
        (+ last-beat 4)
        last-beat)))

(defun write-inline-line (stream line)
  (format stream *inline-line* (name line) (short-name line)
          (midi-instrument (instrument line)) (label line)))

(defun write-line-content (stream line)
  (format stream *line-file-header* (label line) (clef (instrument line)))
  (if (notes line)
      (let ((tuplet-left 0)
            (bar-left 4))
        (dolist (note (reverse (notes line)))
          (format stream "  ")
          (setf (values bar-left tuplet-left)
                (print-note stream note bar-left tuplet-left))
          (format stream "~%"))
        (if (and (/= (last-base line) 2 4) (/= tuplet-left 0))
            (format stream "  }~%")))
      (format stream "R1~%"))
  (format stream *line-file-footer*))

(defun line-able-pitch (line p)
  (instr-able-pitch (instrument line) p))

(defun line-able-time (line base beat in-tuplet)
  (let ((line-beat (beat-n line))
        (line-in-tuplet (in-tuplet line)))
    (or (= line-beat line-in-tuplet 0)
        (> beat line-beat)
        (and (= beat line-beat)
             (or (= line-in-tuplet 0)
                 (and (= base (last-base line))
                      (>= in-tuplet line-in-tuplet)))))))

(defun line-able-note (line note beat in-tuplet)
  (and (line-able-pitch line (pitch note))
       (line-able-time line (base note) beat in-tuplet)))

(defun update-line-state (line note)
  (let* ((base (base note))
         (mult (mult note))
         (line-beat (beat-n line))
         (line-in-tuplet (in-tuplet line))
         (in-tuplet-sum (+ line-in-tuplet (mod mult base))))
    (if (>= in-tuplet-sum base)
        (setf (beat-n line) (+ line-beat (truncate mult base) 1)
              (in-tuplet line) (- in-tuplet-sum base))
        (setf (beat-n line) (+ line-beat (truncate mult base))
              (in-tuplet line) in-tuplet-sum))))

(defun push-note-update-line (line note)
  (push note (notes line))
  (update-line-state line note))

(defun add-note (line note beat in-tuplet)
  (let ((line-beat (beat-n line))
        (line-in-tuplet (in-tuplet line))
        (base (base note)))
    (cond ((= line-beat beat)
           (if (/= line-in-tuplet in-tuplet)
               (push-note-update-line
                line (make-rest base (- in-tuplet line-in-tuplet))))
           (push-note-update-line line note))
          (t (if (/= line-in-tuplet 0)
                 (let ((last-base (last-base line)))
                   (push-note-update-line
                    line (make-rest last-base (- last-base line-in-tuplet)))
                   (setf line-beat (beat-n line))))
             (let ((beat-diff (+ (* base (- beat line-beat)) in-tuplet)))
               (push-note-update-line line (make-rest base beat-diff)))
             (push-note-update-line line note)))))
