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