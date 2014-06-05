(in-package :asdf-user)

(defsystem "dc"
  :description "tcc dc based code"
  :version "0.0.1"
  :author "Raphael Santos <mail@raphaelss.com>"
  :license "MIT License"
  :components ((:file "note")
               (:file "instruments")
               (:file "music" :depends-on ("note"))
               (:file "disscounter")
               (:file "tcc" :depends-on ("music" "disscounter"))))
