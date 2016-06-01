#|
  This file is a part of minisat-driver project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-sat.minisat.driver
  (:use :cl :trivia :alexandria :iterate :cl-sat))
(in-package :cl-sat.minisat.driver)

;; blah blah blah.

(defvar *minisat-home* (asdf:system-relative-pathname :cl-sat.minisat.build "minisat"))

(defun minisat-binary (&optional (*minisat-home* *minisat-home*))
  (merge-pathnames "build/release/bin/minisat" *minisat-home*))


(defmethod solve ((s stream) (solver (eql 'minisat)) &rest options)
  (uiop:run-program (format nil "~{~A ~}" (cons (minisat-binary) options))
                    :input s
                    :output *interactive-output*
                    :error-output *interactive-error*))

