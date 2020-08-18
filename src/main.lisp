(defpackage gender-api
  (:use :cl :with-user-abort)
  (:local-nicknames (:c :clack)
		    (:lr :lack.response)
		    (:l :lack.request))
  (:import-from :gender-api.utils
   :defroute
   :agetf)
  (:export :main))
(in-package :gender-api)

(defun main ()
  (let ((app (make-instance 'ningle:app)))
    (textery:load-grammar (if (uiop:file-exists-p "words.json")
                              "words.json"
                              (namestring
                               (asdf:system-relative-pathname :gender-api
                                                              "src/words.json"))))
    
    (defroute (app "/api/gender" :method :GET)
      (setf (lr:response-headers ningle:*response*)
	    (append (lr:response-headers ningle:*response*)
		    (list :content-type "application/json"))
	    
	    (lr:response-body ningle:*response*)
	    (textery:expand
	     (format nil "{\"name\":\"~a\",\"gender\":\"#gender#\",\"confidence\":~a}"
		     (agetf (l:request-query-parameters ningle:*request*) "name" "")
                     (1- (random 1.0))))))
    
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
      
      ;; in case we're running this through emacs,
      ;;  don't exit
      #-(or slynk swank) (uiop:quit))))

