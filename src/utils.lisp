(defpackage :gender-api.utils
  (:use :cl)
  (:export :defroute :agetf))
(in-package :gender-api.utils)

(defmacro defroute ((app route &rest opts &key &allow-other-keys) &body body)
  `(setf (ningle:route ,app ,route ,@opts)
	 #'(lambda (params)
	     ,@body)))

(declaim (inline agetf))
(defun agetf (place indicator &optional default)
  (or (cdr (assoc indicator place :test #'equal))
      default))
