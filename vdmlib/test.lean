theorem and_commutative (p q : Prop) : p ∧ q → q ∧ p :=
  fun hpq : p ∧ q =>
  have hp : p := And.left hpq
  have hq : q := And.right hpq
  show q ∧ p from And.intro hq hp

/- Define some constants. -/

def m : Nat := 1       -- m is a natural number
def n : Nat := 0
def b1 : Bool := true  -- b1 is a Boolean
def b2 : Bool := false

/- Check their types. -/

#check m
#check n
#check n + 0
#check m * (n + 0)
#check b1-- "&&" is the Boolean and
#check b1 && b2-- Boolean or
#check b1 || b2-- Boolean "true"
#check true/- Evaluate -/

#eval 5 * 4
#eval m + 2
#eval b1 && b2

def double (x : Nat) : Nat :=
 x + x
#eval double 3

variable (α β γ : Type)

def compose (g : β → γ) (f : α → β) (x : α) : γ :=
  g (f x)

def doTwice (h : α → α) (x : α) : α :=
  h (h x)

def doThrice (h : α → α) (x : α) : α :=
  h (h (h x))

#eval if 3 == 3 then 50 else 7

#eval 1 - (2:Int)

def NaturalNumber : Type := Nat

def thirtyEight : NaturalNumber := (38:Nat)

def countdown : Nat → List (IO Unit)
  | 0 => [IO.println "Blast off!"]
  | n + 1 => IO.println s!"{n + 1}" :: countdown n

theorem onePlusOneIsTwo : 1 + 1 = 2 := by
  decide

def mapM [Monad mm] (f : α → mm β) : List α → mm (List β)
  | [] => pure []
  | x :: xs =>
    f x >>= fun hd =>
    mapM f xs >>= fun tl =>
    pure (hd :: tl)

def State (σ : Type) (α : Type) : Type :=
  σ → (σ × α)

#check Type 32

instance : Monad (State σ) where
  pure x := fun s => (s, x)
  bind first next :=
    fun s =>
      let (s', x) := first s
      next x s'

def get : State σ σ :=
  fun s => (s, s)

def set (s : σ) : State σ Unit :=
  fun _ => (s, ())

def increment (howMuch : Int) : State Int Int :=
  get >>= fun i =>
  set (i + howMuch) >>= fun () =>
  pure i

#eval increment 5 7

theorem plusR_zero_left (k : Nat) : k = Nat.add 0 k := by
  induction k <;> simp [Nat.add]
