#|
  This file is a part of cl-sat.minisat project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

#|
  Common Lisp API to minisat

  Author: Masataro Asai (guicho2.71828@gmail.com)
|#



(defsystem cl-sat.minisat
  :version "0.1"
  :author "Masataro Asai"
  :mailto "guicho2.71828@gmail.com"
  :license "LLGPL"
  :depends-on (:trivia :alexandria :iterate :cl-sat :cl-sat.minisat.build)
  :components ((:module "src"
                :components
                ((:file "package"))))
  :description "Common Lisp API to minisat"
  :in-order-to ((test-op (test-op :cl-sat.minisat.test))))
