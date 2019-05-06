
;;;;;
;;;;; What is 5000's prime number (using streams from SICP)
;;;;

(defstruct delay value function)

(defmacro delay (&body body)
  `(make-delay :function #'(lambda () ,@body)))

(defun force (x)
  (if (delay-p x)
    (progn
      (when (delay-function x)
        (setf (delay-value x) (funcall (delay-function x))
              (delay-function x) nil))
      (delay-value x))
    x))

(defmacro cons-stream (x y)
  `(cons ,x (delay ,y)))

(defun stream-car (s)
  (car s))

(defun stream-cdr (s)
  (force (cdr s)))
  
(defparameter the-empty-stream nil)

(defun stream-null (s)
  (null s))

(defun stream-map (proc s)
  (if (stream-null s)
    the-empty-stream
    (cons-stream (funcall proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))

(defun stream-filter (pred s)
  (cond ((stream-null s) the-empty-stream)
        ((funcall pred (stream-car s))
         (cons-stream (stream-car s)
                      (stream-filter pred
                                     (stream-cdr s))))
        (t (stream-filter pred (stream-cdr s)))))

(defun stream-nth (n s)
  (if (zerop n)
    (stream-car s)
    (stream-nth (1- n) (stream-cdr s))))
  
(defun integers-starting-from (n)
  (cons-stream n (integers-starting-from (+ n 1))))

(defvar integers (integers-starting-from 1))

(defun sieve (s)
  (cons-stream
    (stream-car s)
    (sieve (stream-filter
             #'(lambda (x)
                 (plusp (mod x (stream-car s))))
             (stream-cdr s)))))

(defvar *primes* (sieve (integers-starting-from 2)))

(time (assert (= 48619 (stream-nth 5000 *primes*))))
