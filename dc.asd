(in-package :asdf-user)

(defsystem "dc"
  :description "tcc dc based code"
  :version "0.0.1"
  :author "Raphael Santos <contact@raphaelss.com>"
  :license "MIT License"
  :components ((:file "lilytemplates")
               (:file "pitch" :depends-on ("lilytemplates"))
               (:file "note" :depends-on ("lilytemplates" "pitch"))
               (:file "instruments" :depends-on ("pitch"))
               (:file "line" :depends-on
                      ("lilytemplates" "instruments" "note"))
               (:file "score" :depends-on ("lilytemplates" "line"))
               (:file "disscounter")
               (:file "genline" :depends-on
                      ("disscounter" "score" "note" "line"))
               (:file "setup" :depends-on ("genline"))))
