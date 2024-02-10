#check "hello world"
def even(n: nat) : Prop:= ∃ m: nat , n = 2*m

#check even 10
#check even 11
#check ∀ n,even n ∨ even (n+1)
#check ∀ n m, even n → even m → even (n+m)

example : even 10 := ⟨5, rfl⟩

theorem even_add: ∀ m n: nat, even m → even n → even (n+m) = 
take m n,
assumes ⟨k,(hk:m=2*k)⟩,
assume ⟨l,(hl:n=2*l)⟩,
have n + m = 2 * (k + l), by simp [hk, hl, mul_add],
show even (n + m), from ⟨_, this⟩

variables (α : Type) (x : α) 
variables m n : ℕ

#reduce (λ x ↦ x+3) 2 
#eval (λ x: Nat ↦ x+3) 2

deffoo(x: N): N :=x+3 #reduce foo 2
#eval foo 2