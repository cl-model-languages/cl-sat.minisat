#|
  This file is a part of cl-sat.minisat project.
  Copyright (c) 2016 Masataro Asai (guicho2.71828@gmail.com)
|#

(defsystem cl-sat.minisat.test
  :author "Masataro Asai"
  :mailto "guicho2.71828@gmail.com"
  :description "Test system of cl-sat.minisat"
  :license "LLGPL"
  :depends-on (:cl-sat.minisat
               :fiveam)
  :components ((:module "t"
                :components
                ((:file "package"))))
  :perform (test-op :after (op c) (eval (read-from-string "(5am:run! :cl-sat.minisat)"))
))
