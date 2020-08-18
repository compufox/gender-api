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

#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c) :executable t :compression t))
