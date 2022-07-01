#lang pie

; 38
(claim step-length
  (Π ((E U))
    (-> E (List E) Nat
        Nat)))

(define step-length
  (λ (E)
   (λ (e es l)
     (add1 l))))

(claim length
  (Π ((E U))
    (-> (List E)
        Nat)))

(define length
  (λ (E)
    (λ (es)
      (rec-List es
        0
        (step-length E)))))

(check-same Nat (length Nat (:: 1 (:: 2 nil))) 2)
(check-same Nat (length Nat (:: 1 nil)) 1)

; 42
(claim length-Atom
  (-> (List Atom) Nat))

(define length-Atom
  (length Atom))

(check-same Nat (length-Atom (:: 'foo nil)) 1)
(check-same Nat (length-Atom (:: 'foo (:: 'bar nil))) 2)

; 47
(claim step-append
  (Π ((E U))
    (-> E (List E) (List E)
        (List E))))

(define step-append
  (λ (E)
    (λ (x xs append-xs)
      (:: x append-xs))))

(claim append
  (Π ((E U))
    (-> (List E) (List E)
        (List E))))

(define append
  (λ (E)
    (λ (xs ys)
      (rec-List xs
        ys
        (step-append E)))))

(check-same (List Nat) (append Nat (:: 1 nil) (:: 2 nil)) (:: 1 (:: 2 nil)))
(check-same (List Nat) (append Nat (:: 1 nil) (:: 2 (:: 69 nil))) (:: 1 (:: 2 (:: 69 nil))))
