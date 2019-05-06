
;;;;; What is Fibonacci 47's number

(defun fib (n)
  (if (< n 3)
    1
    (+ (fib (- n 1)) (fib (- n 2)))))

(time (assert (= 2971215073 (fib 47))))


