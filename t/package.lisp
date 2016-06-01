#|
  This file is a part of minisat-driver project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage :cl-sat.minisat.driver.test
  (:use :cl
        :cl-sat
        :cl-sat.minisat.driver
        :fiveam
        :trivia :alexandria :iterate))
(in-package :cl-sat.minisat.driver.test)



(def-suite :cl-sat.minisat.driver)
(in-suite :cl-sat.minisat.driver)

;; run test with (run! test-name) 

(test cl-sat.minisat.driver
  (finishes (solve '(and a b c) 'minisat))
  (finishes (solve '(or a b c) 'minisat))
  (finishes (solve '(and (or a !b c) d) 'minisat))
  (finishes (solve '(and (and (and a))) 'minisat))
  (finishes (solve '(not (and a b)) 'minisat))
  (finishes (solve '(not (or a b)) 'minisat)))
