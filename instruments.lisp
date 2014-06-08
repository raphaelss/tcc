(defclass instrument ()
  ((midi-instrument
    :initarg :midi-instrument
    :accessor midi-instrument)
   (main-octave
    :initarg :main-octave
    :accessor main-octave)
   (min-pitch
    :initarg :min-pitch
    :accessor min-pitch)
   (max-pitch
    :initarg :max-pitch
    :accessor max-pitch)
   (clef
    :initarg :clef
    :accessor clef)))

(defparameter *instrument-table* (make-hash-table :test #'eq))

(defun load-instruments (&rest list)
  (mapc #'(lambda (x)
            (let ((id (aref x 0)))
              (setf (gethash id *instrument-table*)
                    (make-instance 'instrument
                                   :midi-instrument (aref x 1)
                                   :main-octave (aref x 2)
                                   :min-pitch (make-pitch (aref x 3))
                                   :max-pitch (make-pitch (aref x 4))
                                   :clef (case (aref x 5)
                                           (treble8h "\"treble^8\"")
                                           (treble "treble")
                                           (treble8l "\"treble_8\"")
                                           (tenor "tenor")
                                           (alto "alto")
                                           (bass8h "\"bass^8\"")
                                           (bass "bass")
                                           (bass8l "\"bass_8\"")))))) list))

(defun instr-able-pitch (instr p)
  (if p
      (let ((pc (pc p))
            (oct (octave p))
            (p1 (min-pitch instr))
            (p2 (max-pitch instr))
            (result nil))
        (dotimes (i (- 9 oct) (nreverse result))
          (let ((cur-oct (+ oct i)))
            (if (pitch-in-range (make-pitch (cons pc (+ oct i))) p1 p2)
                (push cur-oct result)))))
      t))

(load-instruments
 #(piccolo "piccolo" 6 (2 . 5) (9 . 7) treble8h)
 #(flute "flute" 5 (4 . 4) (9 . 6) treble)
 #(oboe "oboe" 4 (4 . 4) (9 . 5) treble)
 #(eng-horn "english horn" 4 (4 . 3) (4 . 5) treble)
 #(clarinet "clarinet" 4 (4 . 3) (4 . 6) treble)
 #(bass-clarinet "clarinet" 3 (4 . 2) (4 . 4) treble8l)
 #(bassoon "bassoon" 3 (4 . 2) (4 . 4) bass)
 #(contrabassoon "bassoon" 1 (9 . 0) (4 . 3) bass8l)
 #(f-horn "french horn" 4 (4 . 3) (0 . 5) treble)
 #(trumpet "trumpet" 4 (0 . 4) (9 . 5) treble)
 #(trombone "trombone" 3 (4 . 2) (4 . 4) bass)
 #(bass-trombone "trombone" 2 (0 . 2) (9 . 3) bass)
 #(tuba "tuba" 2 (9 . 1) (4 . 3) bass)
 #(piano-rh "acoustic grand" 4 (9 . 0) (0 . 8) treble)
 #(piano-lf "acoustic grand" 3 (9 . 0) (0 . 8) bass)
 #(violin-i "violin" 5 (7 . 3) (9 . 6) treble)
 #(violin-ii "violin" 4 (7 . 3) (9 . 6) treble)
 #(viola "viola" 3 (0 . 3) (9 . 5) alto)
 #(cello "cello" 2 (0 . 2) (9 . 4) bass)
 #(bass "contrabass" 2 (4 . 1) (4 . 4) bass8l))
