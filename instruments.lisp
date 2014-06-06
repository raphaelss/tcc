(defclass instrument ()
  ((name
    :initarg :name
    :accessor name)
   (short-name
    :initarg :short-name
    :accessor short-name)
   (midi-instrument
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

(defvar *instrument-list* nil)

(defun load-instruments (&rest list)
  (setf *instrument-list*
        (mapcar #'(lambda (x)
                    (make-instance 'instrument
                                   :name (aref x 0)
                                   :short-name (aref x 1)
                                   :midi-instrument (aref x 2)
                                   :main-octave (aref x 3)
                                   :min-pitch (make-pitch (aref x 4))
                                   :max-pitch (make-pitch (aref x 5))
                                   :clef (case (aref x 6)
                                           (treble8h "\"treble^8\"")
                                           (treble "treble")
                                           (treble8l "\"treble_8\"")
                                           (tenor "tenor")
                                           (alto "alto")
                                           (bass8h "\"bass^8\"")
                                           (bass "bass")
                                           (bass8l "\"bass_8\""))))
                list)))

(load-instruments
 #("Piccolo" "Pic." "piccolo" 6 (2 . 5) (9 . 7) 'treble8h)
 #("Flute" "Fl." "flute" 5 (4 . 4) (9 . 6) 'treble)
 #("Oboe" "Ob." "oboe" 4 (4 . 4) (9 . 5) 'treble)
 #("Eng. Horn" "Eng." "english horn" 4 (4 . 3) (4 . 5) 'treble)
 #("Clarinet Bb" "Cl. Bb" "clarinet" 4 (4 . 3) (4 . 6) 'treble)
 #("Bass Clarinet" " Bass Cl." "clarinet" 3 (4 . 2) (4 . 4) 'treble8l)
 #("Bassoon" "Bas." "bassoon" 3 (4 . 2) (4 . 4) 'bass)
 #("Contrabassoon" "Cntr" "bassoon" 1 (9 . 0) (4 . 3) 'bass8l)
 #("French Horn" "Hrn." "french horn" 4 (4 . 3) (0 . 5) 'treble)
 #("Trumpet" "Trp." "trumpet" 4 (0 . 4) (9 . 5) 'treble)
 #("Trombone" "Trb." "trombone" 3 (4 . 2) (4 . 4) 'bass)
 #("Bass Trombone" "Bass Trb." "trombone" 2 (0 . 2) (9 . 3) 'bass)
 #("Tuba" "Tb." "tuba" 2 (9 . 1) (4 . 3) 'bass)
; #("Harp" "Hrp." "harp" 4 () () 'treble)
; #("Harp" "Hrp." "harp" 4 () () 'bass)
 #("Piano" "Pno." "acoustic grand" 4 (9 . 0) (0 . 8) 'treble)
 #("Piano" "Pno." "acoustic grand" 3 (9 . 0) (0 . 8) 'bass)
 #("Violin I" "Vln. I" "violin" 5 (7 . 3) (9 . 6) 'treble)
 #("Violin II" "Vln. II" "violin" 4 (7 . 3) (9 . 6) 'treble)
 #("Viola" "Vla" "viola" 3 (0 . 3) (9 . 5) 'alto)
 #("Cello" "Vlc." "cello" 2 (0 . 2) (9 . 4) 'bass)
 #("Bass" "Db." "contrabass" 2 (4 . 1) (4 . 4) 'bass8l))
