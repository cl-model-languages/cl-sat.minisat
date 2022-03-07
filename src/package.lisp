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

(defmethod solve ((input pathname) (solver (eql :minisat)) &rest options &key debug &allow-other-keys)
  (remf options :debug)
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
         ;; note: minisat does not correctly return the dmacs output; each line contains a "c" at the beginning of line
         (let* ((instance *instance*)
                (assignments (make-array (length (variables instance))
                                         :element-type '(integer 0 2)
                                         :initial-element 2)))
           (iter
             (for v in-file (format nil "~a/result" dir))
             (when (first-iteration-p)
               (next-iteration))
             (when (= v 0)
               (leave))
             (setf (aref assignments (1- (abs v)))
                   (if (plusp v) 1 0)))
           (iter
             (for a in-vector assignments with-index i)
             (for v = (aref (variables instance) i))
             (case a
               (1 (when (not (eq (find-package :cl-sat.aux-variables)
                                 (symbol-package v)))
                    (collect v into trues)))
               (2 (when (not (eq (find-package :cl-sat.aux-variables)
                                 (symbol-package v)))
                    (collect v into dont-care))))
             (finally
              (return
                (values trues t t dont-care))))))
        ((_ _ 20)
         ;; unsat
         (values nil nil t))))))


