module vdm {
    export reveals *
    export types reveals nat1, seq1, set1, Optional
    export functions reveals 
        override, // ++
        domainExclusion, domainRestriction,  // <:, <-:
        rangeExclusion, rangeRestriction, // :>, :->
        dinter, dunion, 
        conc, 
        rem, iterate,
        abs, div,
        Exists1, elems, inds, nat1
        // Exists1`check
        // Iota
    
    //@vdm.type(`nat1`)
    newtype nat1 = n: nat | n > 0 witness 1
    //@vdm.type(`seq1 of T`)
    type seq1<T> = s: seq<T> | |s| > 0 witness *
    //@vdm.type(`set1 of T`)
    type set1<T(==)> = s: set<T> | |s| > 0 witness * 

    //@vdm.type(`[T]`)
    datatype Optional<T> = of(T) | nil {
        predicate isEmpty() {
            this.nil?
        }

        function get(): T requires !isEmpty() {
            var of(t: T) := this;
            t
        }
    }
    // type inmap<K, V> = im: map<K, V> | mapInjective(im)

    // Check if map is injective, this is hidden in exports
    predicate isInjective<K(==), V(==)>(m: map<K, V>) {
        forall  k1: K 
                |   k1 in m 
                    ::  !exists k2: K 
                        |   k2 in m && k1 != k2 
                            ::  m[k1] == m[k2]
    }

    //@vdm.expression(`map1 ++ map2`) 
    function override<K(!new), V(!new)>(map1: map<K, V>, map2: map<K, V>): (map<K, V>)
        ensures var mov := override(map1, map2);
            mov.Keys == map1.Keys + map2.Keys
    {
        map k: K 
        |   k in (map1.Keys + map2.Keys) 
            ::  k := if k in map2 then map2[k] else map1[k]
    }


    //@vdm.expression(`inverse m`) 
    function inverse<K, V>(m: map<K, V>): map<V, K>
        requires isInjective(m)
        ensures var im := inverse(m);
            im.Keys == m.Values
    {
        map k: K 
            | k in m 
                ::  var v := m[k];
                    v := k
    }
    

    //@vdm.expression(`m :> rng`)  
    function rangeRestriction<K(!new), V(!new)>(m: map<K, V>, rng: set<V>): (map<K, V>)
        ensures var r := rangeRestriction(m, rng);
            r.Values <= rng
    {
        map k: K
        |   k in m && m[k] in rng
            :: k := m[k]
    }
    
    //@vdm.expression(`m :-> rng`) 
    function rangeExclusion<K(!new), V(!new)>(m: map<K, V>, rng: set<V>): (map<K, V>)
        ensures var r := rangeExclusion(m, rng);
            forall v | v in rng :: v !in r.Values
    {
        map k: K
        |   k in m && m[k] !in rng
            :: k := m[k]
    }

    //@vdm.expression(`dom <: m`)
    function domainRestriction<K(!new), V(!new)>(dom: set<K>, m: map<K, V>): (map<K, V>) 
        ensures var r := domainRestriction(dom, m);
            r.Keys <= dom    
    {
        map k: K
        |   k in m && k in dom
            :: k := m[k]
    }

    //@vdm.expression(`dom <-: m`) 
    function domainExclusion<K(!new), V(!new)>(dom: set<K>, m: map<K, V>): (map<K, V>) 
        ensures var r := domainExclusion(dom, m);
            forall k | k in dom :: k !in r
    {
        map k: K
        |   k in m && k !in dom
            :: k := m[k]
    }

    //@vdm.expression(`dunion a, b, c, d`)
    ghost function dunion<T>(ss: set<set<T>>): set<T> 
    {
        // set x: T 
        //     | exists s: set<T> :: s in ss && x in s 
        //     :: x
        {}
    }

    //@vdm.expression(`dinter a, b, c, d`)
    ghost function dinter<T>(s: set<set<T>>): set<T> 
        decreases |s|
    {
        if (s == {}) then {} 
        else 
            var v: set<T> :| v in s;
            v - dinter(s - {v})
    }

    //@vdm.expression(`a munion b`)
    ghost function munion<K(!new), V>(a: map<K, V>, b: map<K, V>): map<K, V> 
    {
        map k | k in (a.Keys + b.Keys)
            :: if k in a then a[k] else b[k]
    }

    // @vdm.expression(`conc a, b, c, d`)
    function conc<T>(s: seq<seq<T>>): seq<T> 
    {
        if (s == []) 
            then [] 
        else
             s[0] + conc(s[1..])
    }

    //@vdm.expression(`a rem b`)
    function rem(a: int, b: int): int 
        requires b != 0
    { a - b * (a / b) }
    
    //@vdm.expression(`abs v`)
    function abs(v: int): int 
    { 
        if v < 0 then 
            -v
        else 
            v 
        }
    
    //@vdm.expression(`func ** n`)
    function iterate<T>(func: T -> T, n: nat): T -> T 
        requires n > 0
    {
        if n == 1 then func
        else 
        (arg0: T) => iterate(func, n - 1)(func(arg0))
    }

    function compose<T1, T2, T3>(f1: T1 -> T2, f2: T2 -> T3): T1 -> T3 {
        (arg: T1) => f2(f1(arg))
    }

    function div(a: int, b: int): int 
        requires b != 0
    {
        a / b
    }

    datatype Exists1<!T(==)> = Set( set<T>, T -> bool ) | Seq( seq<T>, T -> bool ) {
        predicate check()
            ensures var RESULT: bool := this.check();
            match (this)
                case Set(bind, pred) => (RESULT <==> ( |(set v: T | v in bind && pred(v) :: v)| == 1 && exists x :: x in bind && forall y :: y in bind - {x} ==> (pred(x) && !pred(y))))
                case Seq(bind, pred) => (RESULT <==> ( |(set v: T | v in bind && pred(v) :: v)| == 1 && exists x: nat :: x < |bind| && (forall y: nat :: y < |bind| && (y != x) ==> (pred(bind[x]) && !pred(bind[y])))))
        {
            match (this)
                case Set( bind, pred ) => 
                    // There is exactly one value that matches the precicate in the set
                    |(set v: T | v in bind && pred(v) :: v)| == 1
                    // There is a value in the set where the value matches the predicate, and no other values match.
                    && exists x :: x in bind && forall y :: y in bind - {x} ==> (pred(x) && !pred(y))
                
                case Seq( bind, pred ) => 
                    // There is a unique value that matches the predicate
                    |(set v: T | v in bind && pred(v) :: v)| == 1
                    // And that value appears uniquely in the sequence
                    && exists x: nat :: x < |bind| && (forall y: nat :: y < |bind| && (y != x) ==> (pred(bind[x]) && !pred(bind[y])))
        }
    }

    // This is meant to be used in a Iota.Set( bind, exp ).eval(); but may have use in deferred computations?
    // datatype Iota<!T(==)> = Set( set<T>, T -> bool ) | Seq( seq<T>, T -> bool ) {
    //     function eval(): T
    //         requires match (this)
    //             case Set(bind, pred) => Exists1.Set(bind, pred).check()
    //             case Seq(bind, pred) => Exists1.Seq(bind, pred).check()
    //         ensures var RESULT: T := eval();
    //             match (this)
    //                 case Set(bind, pred) => pred(RESULT) && RESULT in bind
    //                 case Seq(bind, pred) => pred(RESULT) && RESULT in bind
    //     {
    //         match (this)
    //             case Set(bind, pred) => var value :| value in bind && pred(value); value
    //             case Seq(bind, pred) => var value :| value in bind && pred(value); value
    //     }
    // }

    function elems<T>(sequence: seq<T>): set<T>
        ensures var el := elems(sequence);
            forall elmt: T | elmt in el :: elmt in sequence
    {
        if (sequence == []) then {}
        else {sequence[0]} + elems(sequence[1..])
    }

    // function distunion<T>(sets: set<set<T>>): set<T> {
    //     set value: T | (exists s: set<T> :: (s in sets) && (value in s)) :: value
    // }

    function inds<T>(sequence: seq<T>): set<nat1> 
        ensures 
            var ind := inds(sequence);
            (sequence != [] ==> ind == set idx: nat1 {:trigger idx < |sequence| as nat1} | idx < |sequence| as nat1 :: idx)
        &&  (sequence == [] ==> ind == {})
            
    {
        if |sequence| == 0 then {} else
        set idx: nat1 {:trigger idx} | idx < |sequence| as nat1 :: idx
    }

    function test(t: int): nat {
        if (t > 0) then t as nat
        else -t
    }
}