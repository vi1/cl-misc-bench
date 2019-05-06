# cl-misc-bench

Benchmarking suite of CL tests.

Add tests to tests/ and run it with run.lisp.

Time in seconds.

Heap size must be at least 4Gb:

$ sbcl --dynamic-space-size 4Gb --no-userinit --load run.lisp --quit

