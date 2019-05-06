
;;;;; How many bits in binary representation of 10^6 factorial

(defun factorial (n)
  (labels ((k (n m)
              (if (<= n m)
                n
                (* (k n (* 2 m))
                   (k (- n m) (* 2 m))))))
    (if (zerop n)
      1
      (k n 1))))

(assert (= 18488885 (time (integer-length (factorial (expt 10 6))))))
