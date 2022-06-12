#lang pie

; 27
(claim +
  (-> Nat Nat
      Nat))

(define +
  (λ (x y)
    (iter-Nat x y (λ (n) (add1 n)))))

(check-same Nat (+ 1 2) 3)
(check-same Nat (+ 5 2) 7)
(check-same Nat (+ 5 zero) 5)