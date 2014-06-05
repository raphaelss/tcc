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
                                   :min-pitch (aref x 4)
                                   :max-pitch (aref x 5)
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
 #("Piccolo" "Pic." "flute" 4 60 72 'treble8h)
 #("Flute" "Fl." "flute" 4 60 72 'treble)
 #("Oboe" "Ob." "oboe" 4 60 72 'treble)
 #("Eng. Horn" "Eng." "oboe" 4 60 72 'treble)
 #("Clarinet Bb" "Cl. Bb" "clarinet" 4 60 72 'treble)
 #("Bassoon" "Bas." "basson" 4 60 72 'bass)
 #("Contrabassoon" "Cntr" "basson" 4 60 72 'bass)
 #("Horn I" "Hrn." "horn" 4 60 72 'treble)
 #("Horn II" "Hrn." "horn" 4 60 72 'treble)
 #("Horn III" "Hrn." "horn" 4 60 72 'treble)
 #("Horn IV" "Hrn." "horn" 4 60 72 'treble)
 #("Trumpet I" "Trp. I" "trumpet" 4 60 72 'treble)
 #("Trumpet III" "Trp. III" "trumpet" 4 60 72 'treble)
 #("Trombone I" "Trb. I" "trombone" 4 60 72 'bass)
 #("Trombone II" "Trb. II" "trombone" 4 60 72 'bass)
 #("Trombone III" "Trb. III" "trombone" 4 60 72 'bass)
 #("Tuba" "Tb." "tuba" 4 60 72 'bass)
 #("Harp" "Hrp." "harp" 4 60 72 'treble)
 #("Harp" "Hrp." "harp" 4 60 72 'bass)
 #("Piano" "Pno." "piano" 4 60 72 'treble)
 #("Piano" "Pno." "piano" 4 60 72 'bass)
 #("Violin I" "Vln. I" "violin" 4 60 72 'treble)
 #("Violin II" "Vln. II" "violin" 4 60 72 'treble)
 #("Cello" "Vlc." "cello" 4 60 72 'bass)
 #("Bass" "Db." "bass" 4 60 72 'bass8l))
