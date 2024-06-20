
module RandomModule {
    export generator reveals Random

    class Random {
        const a: int
        const b: int
        const modulus: nat
        var prev: int

        constructor(seed: int, mult: int, addition: int, m: nat)
            requires m > 0
         { 
            prev := seed; 
            a := mult; 
            b := addition; 
            modulus := m; 
        }

        method gen() returns (r:int)
            requires modulus > 0
            ensures 0 <= r < modulus
            modifies this
        {
            assume {:axiom} 0 <= (a * prev + b) % modulus < modulus;
            r := (a * prev + b) % modulus;
            prev := r;
        }

        method boundedGen(bound: int) returns (r: int)
            requires bound != 0
            ensures 0 <= r < bound // by definition of mod???
            modifies this
        {
            assume {:axiom} modulus > 0;
            r := gen();
            assume {:axiom} 0 <= r % bound < bound; // by definition of mod
            r := r % bound;
        }

        method shuffledSeq(b: nat) returns (r: seq<int>)
            requires b != 0
            // ensures |r| == b
            modifies this
        {
            var test: seq<int> := seq(b, b => b);
            r := [];
            while (|test| > 0)
                decreases |test|
            {
                var rand: int := boundedGen(|test|);
                r := r + [test[rand]];
                test := test[..rand] + test[rand+1..];
            }
        }
    }

    method BinarySortLeft() {

    }

    method BinarySortRight() {

    }

    method Main() {
        
        //@vdm.nondeterministic_setup
        var randomGen: Random := new Random(18293, 10239, 5701, 1930123);
        
        //
        var orderOfStatements: seq<int> := randomGen.shuffledSeq(2);

        while (|orderOfStatements| > 0) 
            decreases orderOfStatements
        {
            //@vdm.non-deterministic.1
            if (orderOfStatements[0] == 0) {
                BinarySortLeft();
            }
            //@vdm.non-deterministic.2
            if (orderOfStatements[0] == 1) {
                BinarySortRight();
            }
            // Get tail of seq 
            orderOfStatements := orderOfStatements[1..];
        }
        //@vdm.statements 
    }
}