
;;;;;
;;;;; In how many ways 100 can be represented as sum of two or more integers
;;;;;

(defun num-change (num list)
  (cond
    ((zerop num) 1)
    ((minusp num) 0)
    ((null list) 0)
    (t
     (+ (num-change num (cdr list))
        (num-change (- num (car list)) list)))))

(time
  (assert (= 190569291
             (num-change 100 (loop for i from 99 downto 1 collect i)))))
