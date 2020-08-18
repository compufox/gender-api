(defpackage gender-api
  (:use :cl :with-user-abort)
  (:local-nicknames (:c :clack)
		    (:lr :lack.response)
		    (:l :lack.request))
  (:import-from :gender-api.utils
   :defroute)
  (:export :main))
(in-package :gender-api)

(defun main ()
  (let ((app (make-instance 'ningle:app)))
    (textery:load-grammar "words.json")
    
    (defroute (app "/api/gender" :method :GET)
      (setf (lr:response-headers ningle:*response*)
	    (append (lr:response-headers ningle:*response*)
		    (list :content-type "application/json"))
	    
	    (lr:response-body ningle:*response*)
	    (textery:expand
	     (format nil "{\"name\":\"~a\",\"gender\":\"#gender#\"}"
		     (or (cdr (assoc "name" (l:request-query-parameters ningle:*request*)
				     :test #'equal))
			 "")))))
    
    (let ((handler (c:clackup app)))
      (handler-case
	  (with-user-abort
	    (bt:join-thread (find-if (lambda (th)
				       (search "hunchentoot" (bt:thread-name th)))
				     (bt:all-threads))))
	(user-abort ())
	(error ()
	  (format t "~&whoopsies!")))
      (format t "~&your gender is now: shutting down")
      (c:stop handler)
      (uiop:quit))))

