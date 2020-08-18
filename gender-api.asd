(defsystem "gender-api"
  :version "0.1.1"
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
  :description ""
  :build-operation "program-op"
  :build-pathname "bin/gender-api"
  :entry-point "gender-api:main")
