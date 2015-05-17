(in-package #:tcc)

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

(defvar *instrument-db* (make-hash-table :test #'eq))

(defun clear-instrument-db ()
  (clrhash *instrument-db*))

(defun add-instrument (id midi-instrument main-octave min-pitch
                       max-pitch clef)
  (setf (gethash id *instrument-db*)
        (make-instance 'instrument :midi-instrument midi-instrument
                       :main-octave main-octave
                       :min-pitch  min-pitch
                       :max-pitch max-pitch
                       :clef clef)))

(defmacro definstrument (id &key midi-instrument main-octave min-pitch max-pitch
                              clef)
  `(add-instrument ',id ,midi-instrument ,main-octave
                   (apply #'make-pitch ,min-pitch)
                   (apply #'make-pitch ,max-pitch)
                   ,clef))

(defun instrument-from-id (id)
  (gethash id *instrument-db*))

(defun instr-able-pitch (instr p)
  (let ((pc (pitch-class p))
        (oct (octave p))
        (p1 (min-pitch instr))
        (p2 (max-pitch instr))
        (result nil))
    (dotimes (i (- 9 oct) (nreverse result))
      (let ((cur-oct (+ oct i)))
        (if (pitch-in-range (make-pitch (cons pc (+ oct i))) p1 p2)
            (push cur-oct result))))))

(defmacro load-instruments (&rest instr-specs)
  (cons 'progn (mapcar #'(lambda (x) (cons 'definstrument x)) instr-specs)))

(load-instruments
 (piccolo :midi-instrument "piccolo"
          :main-octave 6
          :min-pitch '(2 5)
          :max-pitch '(9 7)
          :clef 'treble8h)
 (flute :midi-instrument "flute"
        :main-octave 5
        :min-pitch '(4 4)
        :max-pitch '(9 6)
        :clef 'treble)
 (oboe :midi-instrument "oboe"
       :main-octave 4
       :min-pitch '(4 4)
       :max-pitch '(9 5)
       :clef 'treble)
 (eng-horn :midi-instrument "english horn"
           :main-octave 4
           :min-pitch '(4 3)
           :max-pitch '(4 5)
           :clef 'treble)
 (clarinet :midi-instrument "clarinet"
           :main-octave 4
           :min-pitch '(4 3)
           :max-pitch '(4 6)
           :clef 'treble)
 (bass-clarinet :midi-instrument "clarinet"
                :main-octave 3
                :min-pitch '(4 2)
                :max-pitch '(4 4)
                :clef 'treble8l)
 (bassoon :midi-instrument "bassoon"
          :main-octave 3
          :min-pitch '(4 2)
          :max-pitch '(4 4)
          :clef 'bass)
 (contrabassoon :midi-instrument "bassoon"
                :main-octave 1
                :min-pitch '(9 0)
                :max-pitch '(4 3)
                :clef 'bass8l)
 (f-horn :midi-instrument "french horn"
         :main-octave 4
         :min-pitch '(4 3)
         :max-pitch '(0 5)
         :clef 'treble)
 (trumpet :midi-instrument "trumpet"
          :main-octave 4
          :min-pitch '(0 4)
          :max-pitch '(9 5)
          :clef 'treble)
 (trombone :midi-instrument "trombone"
           :main-octave '3
           :min-pitch '(4 2)
           :max-pitch '(4 4)
           :clef 'bass)
 (bass-trombone :midi-instrument "trombone"
                :main-octave 2
                :min-pitch '(0 2)
                :max-pitch '(9 3)
                :clef 'bass)
 (tuba :midi-instrument "tuba"
       :main-octave 2
       :min-pitch '(9 1)
       :max-pitch '(4 3)
       :clef 'bass)
 (piano-rh :midi-instrument "acoustic grand"
           :main-octave 4
           :min-pitch '(9 0)
           :max-pitch '(0 8)
           :clef 'treble)
 (piano-lf :midi-instrument "acoustic grand"
           :main-octave 3
           :min-pitch '(9 0)
           :max-pitch '(0 8)
           :clef 'bass)
 (violin-i :midi-instrument "violin"
           :main-octave 5
           :min-pitch '(7 3)
           :max-pitch '(9 6)
           :clef 'treble)
 (violin-ii :midi-instrument "violin"
            :main-octave 4
            :min-pitch '(7 3)
            :max-pitch '(9 6)
            :clef 'treble)
 (viola :midi-instrument "viola"
        :main-octave 3
        :min-pitch '(0 3)
        :max-pitch '(9 5)
        :clef 'alto)
 (cello :midi-instrument "cello"
        :main-octave 2
        :min-pitch '(0 2)
        :max-pitch '(9 4)
        :clef 'bass)
 (bass :midi-instrument "contrabass"
       :main-octave 2
       :min-pitch '(4 1)
       :max-pitch '(4 4)
       :clef 'bass8l))
