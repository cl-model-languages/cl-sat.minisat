#|
  This file is a part of minisat-driver project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

#|
  Common Lisp API to minisat

  Author: Masataro Asai (guicho2.71828@gmail.com)
|#



(defsystem cl-sat.minisat.build
  :version "0.1"
  :author "Masataro Asai"
  :mailto "guicho2.71828@gmail.com"
  :license "LLGPL"
  :description "Common Lisp API to minisat"
  :perform (compile-op (op c)
                       (uiop:run-program (format nil "make -C ~a"
                                                 (asdf:system-source-directory :cl-sat.minisat.build))
                                         :output t :error-output t)))
