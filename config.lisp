(defparameter *score*
  (make-score
   :title "Concerto"
   :spec
   '(("woodwind"
      ("flutei" "Flute I" "Fl. I" flute)))))

(defparameter *test-line*
  (car (lines (car (groups *score*)))))

(push (make-instance 'note :base 2 :mult 1) (notes *test-line*))
(push (make-instance 'note :base 2 :mult 1) (notes *test-line*))
(push (make-instance 'note :base 3 :mult 1) (notes *test-line*))
(push (make-instance 'note :base 3 :mult 1) (notes *test-line*))
