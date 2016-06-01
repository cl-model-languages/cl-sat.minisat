#|
  This file is a part of minisat-driver project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

(defsystem cl-sat.minisat.driver.test
  :author "Masataro Asai"
  :mailto "guicho2.71828@gmail.com"
  :description "Test system of cl-sat.minisat.driver"
  :license "LLGPL"
  :depends-on (:cl-sat.minisat.driver
               :fiveam)
  :components ((:module "t"
                :components
                ((:file "package"))))
  :perform (test-op :after (op c) (eval (read-from-string "(every #'fiveam::TEST-PASSED-P (5am:run! :minisat-driver))"))
))
