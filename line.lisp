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
   (notes
    :initarg :notes
    :accessor notes)))

(defun write-inline-line (stream line)
  (format stream *inline-line* (name line) (short-name line)
          (midi-instrument (instrument line)) (label line)))

(defun write-line-content (stream line)
  (format stream *line-file-header* (label line))
  (format stream *line-file-footer*))
