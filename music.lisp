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
#(set-global-staff-size 17)
\\paper {
  #(set-paper-size \"a3\")
  indent = 3.0\\cm
  short-indent = 1.5\\cm
}

\\score {~%~:
  \\new StaffGroup <<~%"))

(defun print-footer (stream)
  (format stream "  >>~%  \\layout {}~%  \\midi {}~%}"))

(defun print-line-header (stream label)
  (format stream "    \\new Staff {~%~:
      \\set Staff.instrumentName = #\"Linha ~a\"~%~:
      \\set Staff.shortInstrumentName = #\"~:*~a\"~%~:
      \\new Voice {~%" label))

(defun print-line-footer (stream)
  (format stream "      }~%    }~%"))

(defun print-poly-cont-line (stream line)
  (print-line-header stream (label line))
  (let ((tuplet-left 0)
        (bar-left 4))
    (dolist (note (reverse (notes line)))
      (format stream "        ")
      (setf (values bar-left tuplet-left)
            (print-note stream note bar-left tuplet-left))
      (format stream "~%"))
    (if (and (/= (base line) 2 4) (/= tuplet-left 0))
        (format stream "        }~%")))
  (print-line-footer stream))

(defun print-poly-cont (stream poly-cont)
  (print-header stream)
  (mapc #'(lambda (x) (print-poly-cont-line stream x)) poly-cont)
  (print-footer stream))
