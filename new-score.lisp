(defpackage #:score
  (:use :cl)
  (:export #:score))

(in-package #:score)

(defclass system ()
  ((long-name :initarg :long-name
              :accessor long-name)
   (short-name :initarg :short-name
               :accessor short-name)))

(defclass group (system)
  ((systems :initform (make-hash-table :test #'eq))))

(defclass single-staff (system)
  ((symbols :initform nil)))

(defclass score ()
  ((title :initarg :title
          :accessor title)
   (subtitle :initarg :subtitle
             :accessor subtitle)
   (subsubtitle :initarg :subsubtitle
                :accessor subsubtitle)
   (composer :initarg :composer
             :accessor composer)
   (systems :initform (make-hash-table :test #'eq)
            :accessor systems)))

(defun get-or-make-subgroup (table id &key long-name short-name)
  (let ((system (gethash id table)))
    (if system
        system
        (setf (gethash id table)
              (make-instance 'group-system :long-name long-name
                             :short-name short-name)))))

(defun make-score (&key title subtitle subsubtitle composer)
  (make-instance 'score :title title :subtitle subtitle
                 :subsubtitle subsubtitle :composer composer))

(defun add-system (score id-list &key long-name short-name instrument)
  (do* ((parent (systems score) (systems (get-or-make-subgroup parent id nil nil)))
        (list id-list (cdr id-list))
        (id (car list) (car list)))
       ((not list) (setf (gethash id parent)
                         (make-instance (if instrument 'single-sytem 'group-system)
                                        :long-name long-name :short-name short-name)))))
