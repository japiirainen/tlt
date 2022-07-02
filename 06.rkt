#lang pie

; 34
(claim first
  (Π ((E U)
      (l Nat))
     (-> (Vec E (add1 l))
         E)))

(define first
  (λ (E l)
    (λ (v)
      (head v))))

(check-same Nat
  (first Nat 1 (vec:: 69 (vec:: 420 vecnil)))
  69)

(check-same Atom
  (first Atom 2 (vec:: 'one (vec:: 'two (vec:: 'three vecnil))))
  'one)

; 43
(claim rest
  (Π ((E U)
      (l Nat))
     (-> (Vec E (add1 l))
         (Vec E l))))

(define rest
  (λ (E l)
    (λ (v)
      (tail v))))


(check-same (Vec Nat 1)
  (rest Nat 1 (vec:: 69 (vec:: 420 vecnil)))
  (vec:: 420 vecnil))

(check-same (Vec Atom 2)
  (rest Atom 2 (vec:: 'one (vec:: 'two (vec:: 'three vecnil))))
  (vec:: 'two (vec:: 'three vecnil)))

(check-same (Vec Atom 3)
  (vec::
    (first Atom 1 (vec:: 'a (vec:: 'b vecnil)))
    (rest  Atom 2 (vec:: 'x (vec:: 'y (vec:: 'z vecnil)))))
  (vec:: 'a (vec:: 'y (vec:: 'z vecnil))))
