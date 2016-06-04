#|
  This file is a part of minisat-driver project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-sat.minisat.driver
  (:use :cl :trivia :alexandria :iterate :cl-sat)
  (:export
   #:minisat))
(in-package :cl-sat.minisat.driver)

;; blah blah blah.

(defvar *minisat-home* (asdf:system-relative-pathname :cl-sat.minisat.build "minisat/"))

(defun minisat-binary (&optional (*minisat-home* *minisat-home*))
  (merge-pathnames "build/release/bin/minisat" *minisat-home*))

(defmethod solve ((input pathname) (solver (eql 'minisat)) &rest options &key &allow-other-keys)
  (with-temp (dir :directory t :template "minisat.XXXXXXXX")
    (let* ((command (format nil "cd ~a; ~a ~{~A~^ ~}~a ~a"
                            (namestring dir)
                            (enough-namestring (minisat-binary))
                            options (namestring input) "result")))
      (uiop:run-program command :output *standard-output* :ignore-error-status t)
      ;; 0 -- indeterminite
      ;; 10 -- sat
      ;; 20 -- unsat
      ;; 
      ;; first token ↓ is either SAT, UNSAT, INDET
      (iter (for token in-file (format nil "~a/result" dir))
            (collect token)))))

