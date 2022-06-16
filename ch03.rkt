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

; 43
(claim zerop
  (-> Nat
      Atom))
(define zerop
  (λ (n)
    (rec-Nat n
      't
      (λ (n-1 zeropn-1)
        'nil))))

(check-same Atom (zerop zero) 't)
(check-same Atom (zerop 1) 'nil)

; 62
(claim *
  (-> Nat Nat
      Nat))

(define *
  (λ (n j)
    (rec-Nat n
      0
      (λ (n-1 *n-1)
        (+ j *n-1)))))

(check-same Nat 10 (* 2 5))
(check-same Nat 15 (* 3 5))