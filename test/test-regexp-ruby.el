;; Don't have a pat-hash for ruby, so we need something that pulls in
;; Ruby.
(load-file "./regexp-helper.el")
(load-file "../dbgr/debugger/rdebug/init.el")

(test-simple-start)

(setq bt  (gethash "rails-backtrace" dbgr-rdebug-pat-hash))

;; FIXME: we get a void variable somewhere in here when running
;;        even though we define it in lexical-let. Dunno why.
;;        setq however will workaround this.
(setq text "/tmp/rails-2.3.5/lib/tasks/databases.rake:360")

(lexical-let ((text "/tmp/rails-2.3.5/lib/tasks/databases.rake:360"))
  
  (assert-t (numberp (loc-match text bt)) "basic traceback location")
  (assert-equal "/tmp/rails-2.3.5/lib/tasks/databases.rake"
		(match-string (dbgr-loc-pat-file-group bt)
			      text) "extract traceback file name")
  (assert-equal "360"
		(match-string (dbgr-loc-pat-line-group bt)
			      text)   "extract traceback line number")
  )

(lexical-let ((text 
	       "/tmp/gems/rake-0.8.7/lib/rake.rb:597:in `invoke_with_call_chain'"))
  
  (assert-t (numberp (loc-match text bt)) "traceback location with in")
  (assert-equal "/tmp/gems/rake-0.8.7/lib/rake.rb"
		(match-string (dbgr-loc-pat-file-group bt)
			      text)   "extract traceback file name 2")
  (assert-equal "597"
		(match-string (dbgr-loc-pat-line-group bt)
			      text)   "extract breakpoint line number 2")
  )

(end-tests)

