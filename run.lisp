
;;;;;
;;;;; Driver: Runs tests from tests/ directory
;;;;;

(declaim (optimize (speed 3)))

(defparameter /dev/null
  (make-two-way-stream (make-concatenated-stream) (make-broadcast-stream)))

;;;
;;; Returns time in secs if OK, nil otherwise
;;;
(defun time-execute (fasl)
  (let ((t0 (get-internal-real-time)))
    (multiple-value-bind (res error) (ignore-errors (load fasl))
      (declare (ignore res))
      (if error
        NIL
        (floor (- (get-internal-real-time) t0) internal-time-units-per-second)))))

;;;
;;; List of .lisp files in dirname sorted
;;;
(defun lisp-pathnames (dirname)
  (sort
    ;;(remove-if-not (lambda (x) (search ".lisp" (namestring x)))
    ;;               (uiop:directory-files dirname))
    (directory (format nil "~A*.lisp" dirname))
    (lambda (x y) (string< (namestring x) (namestring y)))))

;;;
;;; Runs one test
;;;
(defun run-test (pathname)
  (let ((pkg (make-package (gensym "tmp") :use '(:cl))))
    (let* ((*package* pkg)
           (fasl)
           (time))
      (let ((*debug-io* /dev/null)
            (*error-output* /dev/null)
            (*trace-output* /dev/null)
            (*query-io* /dev/null)
            (*terminal-io* /dev/null)
            (*standard-input* /dev/null)
            (*standard-output* /dev/null))
        (setf fasl (compile-file pathname :verbose nil :print nil))
        (when fasl
          (setf time (time-execute fasl))))
      (format t "~A~8T~A~%" time (file-namestring pathname))
      (finish-output)
      (unless time
        (cl-user::quit)))
    (delete-package pkg)
    (cl-user::gc)))

(defun run (dirname)
    (mapc #'run-test (lisp-pathnames dirname)))

(run "tests/")
