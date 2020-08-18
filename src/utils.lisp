(defpackage :gender-api.utils
  (:use :cl)
  (:export :defroute))
(in-package :gender-api.utils)

(defmacro defroute ((app route &rest opts &key &allow-other-keys) &body body)
  `(setf (ningle:route ,app ,route ,@opts)
	 #'(lambda (params)
	     ,@body)))
