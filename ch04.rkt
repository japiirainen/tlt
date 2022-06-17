#lang pie

; 24
(claim flip
  (Π ((A U)
      (D U))
    (-> (Pair A D)
        (Pair D A))))

(define flip
  (λ (A D)
    (λ (p)
      (cons (cdr p) (car p)))))

(check-same
  (Pair Atom Nat)
  (flip Nat Atom (cons 1 'foo))
  (cons 'foo 1))

; 41
(claim elim-Pair
  (Π ((A U)
      (D U)
      (X U))
    (-> (Pair A D)
        (-> A D
            X)
      X)))

(define elim-Pair
  (λ (A D X)
    (λ (p f)
      (f (car p) (cdr p)))))

; 42
(claim kar
  (-> (Pair Nat Nat)
      Nat))

(define kar
  (λ (p)
    (elim-Pair
      Nat Nat
      Nat
      p
      (λ (a d) a))))

(check-same Nat (kar (cons 100 200)) 100)
 
(claim kdr
  (-> (Pair Nat Nat)
      Nat))

(define kdr
  (λ (p)
    (elim-Pair
      Nat Nat
      Nat
      p
      (λ (a d) d))))

(check-same Nat (kdr (cons 100 200)) 200)

(claim swap
  (-> (Pair Nat Atom)
      (Pair Atom Nat)))

(define swap
  (λ (p)
    (elim-Pair
      Nat Atom
      (Pair Atom Nat)
      p
      (λ (a d)
        (cons d a)))))

(check-same
  (Pair Atom Nat)
  (swap (cons 1 'foo))
  (cons 'foo 1))