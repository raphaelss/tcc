(in-package :asdf-user)

(defsystem "dc"
  :description "tcc dc based code"
  :version "0.0.1"
  :author "Raphael Santos <mail@raphaelss.com>"
  :license "MIT License"
  :components ((:file "music")
               (:file "disscounter")
               (:file "tcc" :depends-on ("music" "disscounter"))))
