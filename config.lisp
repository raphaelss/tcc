(require 'asdf)
(setf asdf:*central-registry* '("~/work/tcc/lisp/"))
(asdf:load-system 'dc)

(clear)
(setf *random-state* (make-random-state t))

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
(active-state 5 t)
(active-state 6 t)
(active-state 7 nil)
(active-state 8 nil)
(active-state 9 nil)
(active-state 10 nil)
(active-state 11 nil)
(set-dc 'line 5 "solo/violin")
(set-prob-fun 'line 0 (from-group "string"))
(set-prob-fun 'line 6 (from-group "string"))
(run-until *gen-line-list* 90)

(print-score "~/work/tcc/tests/scotst2.ly" *score*)
