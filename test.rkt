#lang racket

(define hello
  (λ (name)
    (println (string-append "Hello, " name))))

(hello "Racket!")
