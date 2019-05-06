
;;;;;
;;;;; 1111111111111111111 is prime number
;;;;;

(defparameter *nineteen-units* 1111111111111111111)

;;; Brute force
(defun primep (n) 
  (and (> n 1)
       (loop for i from 2 to (isqrt n) never (zerop (mod n i)))))

(time (assert (eq t (primep *nineteen-units*))))
