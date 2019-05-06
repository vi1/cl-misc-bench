
;;;;;
;;;;; Sort 10^6 array of integers multiple times
;;;;;
;;;;; Random number generator is fixed, so unsorted arrays
;;;;; are the same for all lisps
;;;;;

(defvar *n* (expt 10 6))
(defvar *arr* (make-array *n*))
(defvar *unsorted* (make-array *n*))

;; MINSTD random number generator
(let ((a 48271)
      (m 2147483647)
      (x 1))
  (defun minstd-rand-init (&optional (seed 1)) (setf x seed))
  (defun minstd-rand (&optional (range 2147483647))
    (mod (setf x (mod (* a x) m)) range)))

(defun init ()
  (loop initially (minstd-rand-init)
        for i from 0 below *n*
        for r = (minstd-rand) do
        (setf (aref *unsorted* i) r)))
        
(defun test ()
  (init)
  (time
    (loop repeat 50 do
          (loop for i from 0 below *n*
                do (setf (aref *arr* i) (aref *unsorted* i)))
          (sort *arr* #'<))))

(test)
