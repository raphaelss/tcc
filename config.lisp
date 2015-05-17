(require 'asdf)
(setf asdf:*central-registry* '("~/work/tcc/lisp/"))
(asdf:load-system 'dc)

(clear)
(setf *random-state* (make-random-state t))

(set-title "Teste")

;;Sec 1
(active-list 0 1 2 3 4 5 6 7 8 9 10 11)
(run-until *gen-line-list* 60)

;;Sec 2
(active-list 0 5 6 11)
(set-prob-fun 'line 0 (instr-from-group "string"))
(set-prob-fun 'line 6 (instr-from-group "string"))
(set-prob-fun 'line 5 (instr-from-group "solo"))
(set-prob-fun 'line 11 (instr-from-group "solo"))
(run-until *gen-line-list* 90)

;;Sec 3
(active-list 0 1 6 7)
(set-prob-fun 'line 0 (instr-from-group "woodwind"))
(set-prob-fun 'line 6 (instr-from-group "woodwind"))
(set-prob-fun 'line 1 (instr-from-group "solo"))
(set-prob-fun 'line 7 (instr-from-group "solo"))
(run-until *gen-line-list* 120)

;;Sec 4
(active-list 1 2 3 4 7 10)
(set-prob-fun 'line 1 (instr-from-group "woodwind" "brass"))
(set-prob-fun 'line 2 (instr-from-group "woodwind" "brass"))
(set-prob-fun 'line 3 (instr-from-group "woodwind" "brass"))
(set-prob-fun 'line 4 (instr-from-group "solo" "brass" "string"))
(set-prob-fun 'line 7 (instr-from-group "solo"))
(set-prob-fun 'line 10 (instr-from-group "solo"))
(run-until *gen-line-list* 150)

;;Sec 5
(active-list 0 1 2 3 4 5 6 7 8 9 10 11)
(dotimes (i 12)
  (set-prob-fun 'line i (minus-solo)))
(run-until *gen-line-list* 180)

;;Sec 6
(active-list 0 5 6 11)
(set-prob-fun 'line 0 (instr-from-group "string"))
(set-prob-fun 'line 6 (instr-from-group "string"))
(set-prob-fun 'line 5 (instr-from-group "solo"))
(set-prob-fun 'line 11 (instr-from-group "solo"))
(run-until *gen-line-list* 240)

;;Sec 7
(active-list 0 1 2 3 4 5 6 7 8 9 10 11)
(set-prob-fun 'line 0 (minus-solo))
(set-prob-fun 'line 1 (minus-solo))
(set-prob-fun 'line 2 (minus-solo))
(set-prob-fun 'line 3 (minus-solo))
(set-prob-fun 'line 4 (minus-solo))
(set-prob-fun 'line 5 (minus-solo))
(set-prob-fun 'line 6 (instr-from-group "solo"))
(set-prob-fun 'line 7 (instr-from-group "solo"))
(set-prob-fun 'line 8 (instr-from-group "solo"))
(set-prob-fun 'line 9 (instr-from-group "solo"))
(set-prob-fun 'line 10 (instr-from-group "solo"))
(set-prob-fun 'line 11 (instr-from-group "solo"))
(run-until *gen-line-list* 360)

;;Sec 8
(active-list 0 5 6 11)
(set-prob-fun 'line 0 (instr-from-group "string"))
(set-prob-fun 'line 5 (instr-from-group "string"))
(set-prob-fun 'line 6 (instr-from-group "string"))
(set-prob-fun 'line 11 (instr-from-group "string"))
(run-until *gen-line-list* 390)

;;Sec 9
(active-list 2 3 4 7 8 9 10)
(set-prob-fun 'line 2 (instr-from-group "solo"))
(set-prob-fun 'line 3 (instr-from-group "solo"))
(set-prob-fun 'line 5 (instr-from-group "solo"))
(set-prob-fun 'line 7 (instr-from-group "woodwind" "string"))
(set-prob-fun 'line 8 (instr-from-group "woodwind" "string"))
(set-prob-fun 'line 9 (instr-from-group "woodwind" "string"))
(set-prob-fun 'line 10 (instr-from-group "woodwind" "string"))
(run-until *gen-line-list* 450)

;;Sec 10
(active-list 0 1 2 3 4 5 6 7 8 9 10 11)
(set-prob-fun 'line 0 (instr-from-group "solo"))
(set-prob-fun 'line 1 (instr-from-group "solo"))
(set-prob-fun 'line 2 (instr-from-group "solo"))
(set-prob-fun 'line 3 (instr-from-group "solo"))
(set-prob-fun 'line 4 (instr-from-group "solo"))
(set-prob-fun 'line 5 (instr-from-group "solo"))
(set-prob-fun 'line 6 (minus-solo))
(set-prob-fun 'line 7 (minus-solo))
(set-prob-fun 'line 8 (minus-solo))
(set-prob-fun 'line 9 (minus-solo))
(set-prob-fun 'line 10 (minus-solo))
(set-prob-fun 'line 11 (minus-solo))
(run-until *gen-line-list* 510)

;;Sec 11
(active-list 0 1 2 3 4 5 6 7 8 9 10 11)
(dotimes (i 12)
  (set-prob-fun 'line i (instr-from-group "solo")))
(run-until *gen-line-list* 570)

;;Sec 12
(active-list 0 1 2 3 4 5 6 7 8 9 10 11)
(dotimes (i 12)
  (if (oddp i)
      (set-prob-fun 'line i (instr-from-group "solo"))
      (set-prob-fun 'line i (minus-solo))))
(run-until *gen-line-list* 600)

(print-score "~/work/tcc/tests/scotst3.ly" *score*)
