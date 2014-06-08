(defclass score ()
  ((title
    :initarg :title
    :initform ""
    :accessor title)
   (subtitle
    :initarg :subtitle
    :initform ""
    :accessor subtitle)
   (subsubtitle
    :initarg :subsubtitle
    :initform ""
    :accessor subsubtitle)
   (groups
    :initarg :groups
    :initform ()
    :accessor groups)))

(defclass group ()
  ((label
    :initarg :label
    :accessor label)
   (lines
    :initarg :lines
    :initform ()
    :accessor lines)))

(defun write-group-header (stream group)
  (format stream *group-header* (label group)))

(defun write-group-footer (stream)
  (format stream *group-footer*))

(defun write-group (stream group)
  (write-group-header stream group)
  (dolist (line (lines group))
    (write-inline-line stream line))
  (write-group-footer stream))

(defun write-score-header (stream base-path score)
  (format stream "~a~%~%" *lily-version*)
  (dolist (g (groups score))
    (dolist (line (lines g))
      (let ((file-path (format nil "~a_~a.ly" base-path (label line))))
        (format stream *lily-include* (file-namestring file-path))
        (format stream "~%")
        (with-open-file (content-stream
                         file-path
                         :direction :output
                         :if-exists :supersede
                         :if-does-not-exist :create)
          (write-line-content content-stream line)))))
  (format stream "~%")
  (format stream *score-header* (title score) (subtitle score)
          (subsubtitle score)))

(defun write-score-footer (stream)
  (format stream *score-footer*))

(defun print-score (file-path score)
  (with-open-file (stream
                   file-path
                   :direction :output
                   :if-exists :supersede
                   :if-does-not-exist :create)
    (write-score-header stream (subseq file-path 0 (position #\. file-path))
                        score)
    (dolist (g (groups score))
      (write-group stream g))
    (write-score-footer stream)))

(defun make-score (&key (title "") (subtitle "") (subsubtitle "")
                     (spec ()))
  (let* ((sco (make-instance 'score :title title :subtitle subtitle
                             :subsubtitle subsubtitle))
         (groups ()))
    (dolist (group-spec spec)
      (let* ((g (make-instance 'group :label (car group-spec)))
             (lines ()))
        (dolist (line-spec (cdr group-spec))
          (push (make-instance 'line :label (car line-spec)
                               :name (cadr line-spec)
                               :short-name (caddr line-spec)
                               :instrument (gethash (cadddr line-spec)
                                                    *instrument-table*))
                lines))
        (setf (lines g) (nreverse lines))
        (push g groups)))
    (setf (groups sco) (reverse groups))
    sco))

(defun split-label (label)
  (let ((pos (position #\/ label)))
    (values (subseq label 0 pos) (subseq label (+ pos 1)))))

(defun score-get-line (score label)
  (multiple-value-bind (group-label line-label) (split-label label)
    (let ((group (find group-label (groups score) :test #'equal :key #'label)))
      (if group
          (find line-label (lines group) :test #'equal :key #'label)))))

(defun score-apply (score label fun &rest args)
  (apply fun (score-get-line score label) args))
