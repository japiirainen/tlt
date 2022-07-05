#lang pie

(claim +
  (-> Nat Nat
      Nat))

(define +
  (λ (x y)
    (iter-Nat x
      y
      (λ (z)
        (add1 z)))))

; 21
(claim double
  (-> Nat
      Nat))

(define double
  (λ (x)
    (iter-Nat x
      0
      (+ 2))))

(check-same Nat (double 2) 4)

; 22
(claim twice
  (-> Nat
      Nat))

(define twice
  (λ (x)
    (+ x x)))

(check-same Nat (twice 2) 4)

; 23
(claim twice=double
  (Pi ((n Nat))
      (= Nat (twice n) (double n))))

(claim add1+=+add1
  (Pi ((n Nat)
       (j Nat))
      (= Nat
         (add1 (+ n j))
         (+ n (add1 j)))))

(claim mot-add1+=+add1
  (-> Nat Nat
      U))

(define mot-add1+=+add1
  (λ (j k)
    (= Nat
       (add1 (+ k j))
       (+ k (add1 j)))))

(claim step-add1+=+add1
  (Π ((m Nat)
       (n-1 Nat))
    (→ (mot-add1+=+add1 m n-1)
        (mot-add1+=+add1 m (add1 n-1)))))

(define step-add1+=+add1
  (λ (m n-1)
    (λ (add1+=+add1_n-1)
      (cong add1+=+add1_n-1 (+ 1)))))

(define add1+=+add1
  (λ (n j)
    (ind-Nat n
      (mot-add1+=+add1 j)
      (same (add1 j))
      (step-add1+=+add1 j))))

(claim mot-twice=double
  (-> Nat U))

(define mot-twice=double
  (λ (k)
    (= Nat (twice k) (double k))))

(claim step-twice=double
  (Π ((n-1 Nat))
    (→ (mot-twice=double n-1)
        (mot-twice=double (add1 n-1)))))

(claim mot-step-twice=double
  (-> Nat Nat
      U))

(define mot-step-twice=double
  (λ (n-1 k)
    (= Nat
       (add1 k)
       (add1 (add1 (double n-1))))))

(define step-twice=double
  (λ (n-1)
    (λ (twice=double_n-1)
      (replace (add1+=+add1 n-1 n-1)
               (mot-step-twice=double n-1)
               (cong twice=double_n-1 (+ 2))))))

(define twice=double
  (λ (n)
    (ind-Nat n
      mot-twice=double
      (same zero)
      step-twice=double)))

(claim twice=double-of-17
  (= Nat (twice 17) (double 17)))

(claim twice=double-of-17-again
  (= Nat (twice 17) (double 17)))

(define twice=double-of-17
  (twice=double 17))

(define twice=double-of-17-again
  (same 34))


(check-same Nat (twice 17) (double 17))
(check-same (= Nat 34 34) (twice=double 17) (same 34))

(claim id
  (Π ((u U))
    (→ u u)))

(define id
  (λ (E x) x))

(check-same Nat (id Nat 1) 1)
(check-same Atom (id Atom 'a) 'a)

(claim id-again
  (Π ((u U))
    (→ u u)))

(define id-again
  (λ (E y) y))

(claim id=id-again
  (Π ((u U)
      (v u))
    (= u
       (id u v)
       (id-again u v))))

(define id=id-again
  (λ (E v)
    (same v)))

(check-same (= Nat 1 1) (id=id-again Nat 1) (same 1))
(check-same (= Atom 'a 'a) (id=id-again Atom 'a) (same 'a))

(claim id-again=id
  (Π ((u U)
      (v u))
    (= u
       (id-again u v)
       (id u v))))

(define id-again=id
  (λ (E v)
    (symm (id=id-again E v))))

(check-same (= Nat 1 1) (id-again=id Nat 1) (same 1))
(check-same (= Atom 'a 'a) (id-again=id Atom 'a) (same 'a))
