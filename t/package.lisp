#|
  This file is a part of cl-sat.minisat project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage :cl-sat.minisat.test
  (:use :cl
        :cl-sat
        :cl-sat.minisat
        :fiveam
        :trivia :alexandria :iterate))
(in-package :cl-sat.minisat.test)



(def-suite :cl-sat.minisat)
(in-suite :cl-sat.minisat)

;; run test with (run! test-name) 

(test cl-sat.minisat
  (is-true (nth-value 1 (solve '(and a b c) :minisat :debug t)))
  (is-true (nth-value 1 (solve '(or a b c) :minisat :debug t)))
  (is-true (nth-value 1 (solve '(and (or a !b c) d) :minisat :debug t)))
  (is-true (nth-value 1 (solve '(and (and (and a))) :minisat :debug t)))
  (is-true (nth-value 1 (solve '(not (and a b)) :minisat :debug t)))
  (is-true (nth-value 1 (solve '(not (or a b)) :minisat :debug t)))
  (is-false (nth-value 1 (solve '(and a !a) :minisat :debug t))))

(test cl-sat.minisat.no-debug
  (is-true (nth-value 1 (solve '(and a b c) :minisat)))
  (is-true (nth-value 1 (solve '(or a b c) :minisat)))
  (is-true (nth-value 1 (solve '(and (or a !b c) d) :minisat)))
  (is-true (nth-value 1 (solve '(and (and (and a))) :minisat)))
  (is-true (nth-value 1 (solve '(not (and a b)) :minisat)))
  (is-true (nth-value 1 (solve '(not (or a b)) :minisat)))
  (is-false (nth-value 1 (solve '(and a !a) :minisat))))
