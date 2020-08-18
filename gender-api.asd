(defsystem "gender-api"
  :version "0.1.0"
  :author "ava fox"
  :license "NPLv1+"
  :depends-on ("ningle"
               "hunchentoot"
               "clack"
               "with-user-abort"
	       "textery")
  :components ((:module "src"
                :components
                ((:file "utils")
		 (:file "main"))))
  :description "")
