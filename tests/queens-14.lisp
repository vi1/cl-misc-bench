;;;;;
;;;;; Queens problem for n = 14
;;;;;

(defconstant n 14)
(defvar *count* 0)
(defvar *board* (make-array n))
(defun ok (i)
  (loop with x = (aref *board* i)
        for j from 0 below i
        for y = (aref *board* j)
        for d = (- x y)
        when (or (zerop d) (= (- i j) (abs d)))
        do (return-from ok nil))
  t)
(defun put (i)
  (loop for pos from 0 below n do
        (setf (aref *board* i) pos)
        (when (ok i)
          (if (= i (1- n))
              (incf *count*)
              (put (1+ i))))))
(time (put 0))
(assert (= 365596 *count*))
