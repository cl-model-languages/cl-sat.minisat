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
  :depends-on (:trivia :alexandria :iterate :cl-sat)
  :components ((:module "src"
                        :components
                        ((:file "package"))))
  :description "Common Lisp API to minisat"
  :in-order-to ((test-op (test-op :cl-sat.minisat.test)))
  :defsystem-depends-on (:trivial-package-manager)
  :perform
  (load-op :before (op c)
           (uiop:symbol-call :trivial-package-manager
                             :ensure-program
                             "minisat"
                             :apt "minisat"
                             :dnf "minisat2"
                             :yum "minisat2"
                             :brew "minisat"
                             :macports "minisat"
                             :env-alist `(("PATH" . ,(format nil "~a:~a"
                                                             (asdf:system-relative-pathname
                                                              :cl-sat.minisat "minisat/build/release/bin/")
                                                             (uiop:getenv "PATH"))))
                             :from-source (format nil "make -C ~a"
                                                  (asdf:system-source-directory :cl-sat.minisat)))))
