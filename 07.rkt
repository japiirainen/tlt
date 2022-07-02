#lang pie

; 13
(claim mot-peas
  (→ Nat
     U))

(define mot-peas
  (λ (k)
    (Vec Atom k)))

; 20
(claim step-peas
  (Π ((l-1 Nat))
     (→ (mot-peas l-1)
        (mot-peas (add1 l-1)))))

(define step-peas
  (λ (l-1)
    (λ (peasl-1)
      (vec:: 'pea peasl-1))))

; 25
(claim peas
  (Π ((n Nat))
    (Vec Atom n)))

(define peas
  (λ (n)
    (ind-Nat n
      mot-peas
      vecnil
      step-peas)))

(check-same (Vec Atom 0) (peas 0) vecnil)
(check-same (Vec Atom 1) (peas 1) (vec:: 'pea vecnil))
(check-same (Vec Atom 2) (peas 2) (vec:: 'pea (vec:: 'pea vecnil)))

; 28
(claim last
  (Π ((E U)
      (l Nat))
     (→ (Vec E (add1 l))
        E)))

(claim base-last
  (Π ((E U))
     (→ (Vec E (add1 zero))
        E)))

(define base-last
  (λ (E)
    (λ (v)
      (head v))))

(claim mot-last
  (→ U Nat
    U))

(define mot-last
  (λ (E n)
    (→ (Vec E (add1 n))
       E)))

(claim step-last
  (Π ((E U)
      (l-1 Nat))
     (→ (mot-last E l-1)
        (mot-last E (add1 l-1)))))

(define step-last
  (λ (E l-1)
    (λ (lastl-1)
      (λ (es)
        (lastl-1 (tail es))))))

(define last
  (λ (E l)
    (ind-Nat l
    (mot-last E)
    (base-last E)
    (step-last E))))

(check-same Nat
  (last Nat 1 (vec:: 69 (vec:: 420 vecnil)))
  420)
(check-same Atom
  (last Atom 2 (vec:: 'foo (vec:: 'bar (vec:: 'baz vecnil))))
  'baz)

(claim pies
  (Π ((n Nat))
    (Vec Atom n)))

(define pies
  (λ (n)
    (ind-Nat n
      (λ (k)
        (Vec Atom k))
      vecnil
      (λ (n-1 almost)
        (vec:: 'pie almost)))))

(check-same (Vec Atom 0) (pies 0) vecnil)
(check-same (Vec Atom 2) (pies 2) (vec:: 'pie (vec:: 'pie vecnil)))
(check-same (Vec Atom 3) (pies 3) (vec:: 'pie (vec:: 'pie (vec:: 'pie vecnil))))

(check-same Atom (last Atom 9999 (pies 10000)) 'pie)
