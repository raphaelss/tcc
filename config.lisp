(require 'asdf)
(setf asdf:*central-registry* '("~/work/tcc/lisp/"))
(asdf:load-system 'dc)

(set-title "Teste")

;;Sec 1
(dotimes (i 12)
  (active-state i t))
(run-until *gen-line-list* 60)

;;Sec 2
(active-state 0 t)
(active-state 1 nil)
(active-state 2 nil)
(active-state 3 nil)
(active-state 4 nil)
(active-state 5 nil)
(active-state 6 t)
(active-state 8 nil)
(active-state 9 nil)
(active-state 10 nil)
(active-state 11 nil)

(run-until *gen-line-list* 90)


(print-score "~/work/tcc/tests/scotst.ly" *score*)
