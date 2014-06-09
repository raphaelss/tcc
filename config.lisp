(require 'asdf)
(setf asdf:*central-registry* '("~/work/tcc/lisp/"))
(asdf:load-system 'dc)

(setf *score-title* "Teste")

;;Sec 1
(active-state 0 nil)
(active-state 1 nil)
(active-state 2 nil)
(active-state 3 nil)
(active-state 4 nil)
(active-state 5 nil)
(active-state 6 nil)
(active-state 7 nil)
(active-state 8 nil)
(active-state 9 nil)
(run-until *gen-line-list* 60)
(print-score "~/work/tcc/tests/scotst.ly" *score*)
