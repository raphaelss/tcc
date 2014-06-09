(require 'asdf)
(setf asdf:*central-registry* '("~/work/tcc/lisp/"))
(asdf:load-system 'dc)

(set-title "Teste")

;;Sec 1
(active-state 3 nil)
(active-state 4 nil)
(active-state 5 nil)
(active-state 6 nil)
(run-until *gen-line-list* 60)
(print-score "~/work/tcc/tests/scotst.ly" *score*)
