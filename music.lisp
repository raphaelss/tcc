(defclass poly-cont-line ()
  ((label
    :initarg :label
    :accessor label)
   (base
    :initarg :base
    :initform 2
    :accessor base)
   (notes
    :initarg :notes
    :initform ()
    :accessor notes)))

(defun add-note (line note)
  (setf (notes line) (cons note (notes line))))

(defun print-header (stream)
  (format stream "\\version \"2.18.2\"~%~%~
\\score {~%~:
  \\new StaffGroup <<~%"))

(defun print-footer (stream)
  (format stream "  >>~%  \\layout {}~%  \\midi {}~%}"))

(defun print-line-header (stream label bar)
  (format stream "    \\new Staff {~%~:
      \\set Staff.instrumentName = #\"Linha ~a\"~%~:
      \\set Staff.shortInstrumentName = #\"~a\"~%~:
      \\new Voice {~%        \\time ~a/4~%        " label label bar))

(defun print-line-footer (stream)
  (format stream "      }~%    }~%"))

(defun print-poly-cont-line (stream bar-beats line)
  (print-line-header stream (label line) bar-beats)
  (let* ((base (base line))
         (bar (* bar-beats base))
         (bar-left bar)
         (tuplet-left 0))
    (dolist (note (reverse (notes line)))
      (setf (values bar-left tuplet-left)
            (print-note stream note base bar bar-left tuplet-left))
      (format stream " "))
    (if (and (/= base 2 4) (/= tuplet-left 0))
        (format stream "}")))
  (format stream "~%")
  (print-line-footer stream))

(defun print-poly-cont (stream bar poly-cont)
  (print-header stream)
  (mapcar #'(lambda (x)
              (print-poly-cont-line stream bar x))
          poly-cont)
  (print-footer stream))
