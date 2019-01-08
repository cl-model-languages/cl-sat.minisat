#|
  This file is a part of cl-sat.minisat project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-sat.minisat
  (:use :cl :trivia :alexandria :iterate :cl-sat)
  (:export
   #:*minisat-home*))
(in-package :cl-sat.minisat)

;; blah blah blah.

(defvar *minisat-home* (asdf:system-relative-pathname :cl-sat.minisat "minisat/"))

(defun minisat-binary (&optional (*minisat-home* *minisat-home*))
  (if (trivial-package-manager:which "minisat")
      "minisat"
      (merge-pathnames "build/release/bin/minisat" *minisat-home*)))

(defmethod solve ((input pathname) (solver (eql :minisat)) &rest options &key debug)
  (with-temp (dir :directory t :template "minisat.XXXXXXXX" :debug debug)
    (let* ((command (format nil "cd ~a; ~a ~{~A~^ ~} ~a ~a"
                            (namestring dir)
                            (namestring (minisat-binary))
                            options (namestring input) "result")))
      (format t "~&; ~a" command)
      (multiple-value-match (uiop:run-program command :output *standard-output* :error-output *error-output* :ignore-error-status t)
        ((_ _ 0)
         ;; indeterminite
         (values nil nil nil))
        ((_ _ 10)
         ;; sat
         (parse-dimacs-output (format nil "~a/result" dir) *instance*))
        ((_ _ 20)
         ;; unsat
         (values nil nil t))))))


