
(defconstant n (* 2 (expt 10 8)))

(defun f3 (i)
  (if (zerop (mod i 113))
      (throw t 113)
      i))

(defun f2 (i)
  (if (zerop (mod i 17))
      (throw t 17)
      (f3 i)))
  
(defun f1 (i)
  (if (zerop (mod i 7))
      (throw t 7)
      (f2 i)))
      
(defun main ()
  (loop for i from 0 below n sum (mod (catch t (f1 i)) 17)))

(time (assert (= 1574998114 (main))))