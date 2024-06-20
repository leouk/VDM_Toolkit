/*
 *  @vdm.module(Conway)
 *  Automatically translated via VDM2Dafny translator tool
 *  @author Adam Winstanley
 */
include "D:/University Year 3/y4/dafny-to-vdm-examples/VdmToDafny/target/classes/vdm.dfy"
module Conway {
    import vdm


    ////////////////////////////////////////////////////////////////////////////////////////////////////     
    ///////////////////////////////////////////// CONSTANTS ////////////////////////////////////////////     
    ////////////////////////////////////////////////////////////////////////////////////////////////////     

    const GENERATE: int := 3;

    const SURVIVE: set<int> := {2, 3};

    const AROUND: set<int> := {(-1), 0, (1)};

    const MAX_NEIGHBOURS: int := 9;

    const BLOCK: set<Point> := {mk_Point(0, 0), mk_Point((-1), 0), mk_Point(0, (-1)), mk_Point((-1), (-1))}; 

    const BLINKER: set<Point> := {mk_Point((-1), 0), mk_Point(0, 0), mk_Point(1, 0)};

    const TOAD: set<Point> := (BLINKER + {mk_Point(0, (-1)), mk_Point((-1), (-1)), mk_Point((-2), (-1))});   

    const BEACON: set<Point> := {mk_Point((-2), 0), mk_Point((-2), 1), mk_Point((-1), 1), mk_Point(0, (-2)), 
mk_Point(1, (-2)), mk_Point(1, (-1))};

    const PULSAR: set<Point> := var quadrant: set<Point> :| quadrant == {mk_Point(2, 1), mk_Point(3, 1), mk_Point(3, 2), mk_Point(1, 2), mk_Point(1, 3), mk_Point(2, 3), mk_Point(5, 2), mk_Point(5, 3), mk_Point(6, 3), mk_Point(7, 3), mk_Point(2, 5), mk_Point(3, 5), mk_Point(3, 6), mk_Point(3, 7)};
    (((quadrant + (set x: int, y: int | Point.mk_Point(x, y) in quadrant :: mk_Point((-x), y))) + (set x: int, y: int | Point.mk_Point(x, y) in quadrant :: mk_Point(x, (-y)))) + (set x: int, y: int | Point.mk_Point(x, 
y) in quadrant :: mk_Point((-x), (-y))));

    const DIEHARD: set<Point> := {mk_Point(0, 1), mk_Point(1, 1), mk_Point(1, 0), mk_Point(0, 5), mk_Point(0, 6), mk_Point(0, 7), mk_Point(2, 6)};

    const GLIDER: set<Point> := {mk_Point(1, 0), mk_Point(2, 0), mk_Point(3, 0), mk_Point(3, 1), mk_Point(2, 
2)};

    const GOSPER_GLIDER_GUN: set<Point> := {mk_Point(2, 0), mk_Point(2, 1), mk_Point(2, 2), mk_Point(3, 0), mk_Point(3, 1), mk_Point(3, 2), mk_Point(4, (-1)), mk_Point(4, 3), mk_Point(6, (-2)), mk_Point(6, (-1)), mk_Point(6, 3), mk_Point(6, 4), mk_Point(16, 1), mk_Point(16, 2), mk_Point(17, 1), mk_Point(17, 2), mk_Point((-1), (-1)), mk_Point((-2), (-2)), mk_Point((-2), (-1)), mk_Point((-2), 0), mk_Point((-3), (-3)), mk_Point((-3), 1), mk_Point((-4), (-1)), mk_Point((-5), (-4)), mk_Point((-5), 2), mk_Point((-6), (-4)), mk_Point((-6), 2), mk_Point((-7), (-3)), mk_Point((-7), 1), mk_Point((-8), (-2)), mk_Point((-8), (-1)), mk_Point((-8), 0), mk_Point((-17), (-1)), mk_Point((-17), 0), mk_Point((-18), (-1)), mk_Point((-18), 0)};

    ////////////////////////////////////////////////////////////////////////////////////////////////////     
    /////////////////////////////////////////////// TYPES //////////////////////////////////////////////     
    ////////////////////////////////////////////////////////////////////////////////////////////////////     

    //@vdm.type(Point)
    type Point = ImplPoint'

    datatype ImplPoint' = mk_Point(x: int, y: int)

    //@vdm.type.methods(Point)


    //@vdm.type()
    type Population = set<Point>//@vdm.type.methods(Population)


    //@vdm.type(Value)
    type Value = varValue: ImplValue'
        | inv_Value(varValue)// witness @vdm.warning(This may need a witness)

    datatype ImplValue' = mk_Value(x: int, y: int)

    //@vdm.type.methods(Value)

    //@vdm.function(`inv_Value`)
    predicate inv_Value(arg0: Value)
    {
        //@vdm.patterns
        //@vdm.pattern_matching
        var x, y :| arg0 == Value.mk_Value(x, y);

        //@vdm.function.body
        ((x > 0) && (y > 0))
    }


    //@vdm.function(`ord_Value`)
    predicate ord_Value(p1_: Value, p2_: Value)
    {
        //@vdm.function.body
        var a: Value :| a == p1_;
        var b: Value :| b == p2_;
        (a.y < b.y)}


    //@vdm.function(`eq_Value`)
    predicate eq_Value(p1_: Value, p2_: Value)
    {
        //@vdm.function.body
        var a: Value :| a == p1_;
        var b: Value :| b == p2_;
        ((a.x == b.x) && (a.y == b.y))}

    //@vdm.implicit(`max_Value`)
    function max_Value(arg0: Value, arg1: Value): Value {
        if ((ord_Value(arg0, arg1)) || eq_Value(arg0, arg1)) then arg1 else arg0
    }

    //@vdm.implicit(`min_Value`)
    function min_Value(arg0: Value, arg1: Value): Value {
        if ((ord_Value(arg0, arg1)) || eq_Value(arg0, arg1)) then arg0 else arg1
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////     
    ///////////////////////////////////////////// FUNCTIONS ////////////////////////////////////////////     
    ////////////////////////////////////////////////////////////////////////////////////////////////////     


    //@vdm.function(`compare`)
    predicate compare(a: Value, b: Value)
    {
        //@vdm.function.body
        (ord_Value(a, b))}


    //@vdm.function(`around`)
    function around(p: Point): set<Point>
        ensures var RESULT := around(p);
                ((! (p in RESULT)) && ((| RESULT |) < MAX_NEIGHBOURS))
    {

        //@vdm.function.body
        ((set x: int, y: int | x in AROUND && y in AROUND :: mk_Point((p.x + x), (p.y + y))) - {p})
    }


    //@vdm.function(`neighbours`)
    function neighbours(pop: Population, p: Point): Population
        ensures var RESULT := neighbours(pop, p);
                ((| RESULT |) < MAX_NEIGHBOURS)
    {

        //@vdm.function.body
        (set q: Point | (q in pop) && q in around(p) :: q)
    }


    //@vdm.function(`neighbourCount`)
    function neighbourCount(pop: Population, p: Point): nat
        ensures var RESULT := neighbourCount(pop, p);
                (RESULT < MAX_NEIGHBOURS)
    {

        //@vdm.function.body
        (| neighbours(pop, p) |)
    }


    //@vdm.function(`newCells`)
    function newCells(pop: Population): set<Point>
        ensures var RESULT := newCells(pop);
                ((RESULT * pop) == {})
    {

        //@vdm.function.body
        (vdm.dunion((set p: Point | p in pop :: (set q: Point | ((q !in pop) && (neighbourCount(pop, q) == GENERATE)) && q in around(p) :: q))))
    }


    //@vdm.function(`deadCells`)
    function deadCells(pop: Population): set<Point>
        ensures var RESULT := deadCells(pop);
                ((RESULT * pop) == RESULT)
    {

        //@vdm.function.body
        (set p: Point | (neighbourCount(pop, p) !in SURVIVE) && p in pop :: p)
    }


    //@vdm.function(`generation`)
    function generation(pop: Population): Population
    {

        //@vdm.function.body
        ((pop - deadCells(pop)) + newCells(pop))
    }


    //@vdm.function(`generations`)
    function generations(n: vdm.nat1, pop: Population): seq<Population>
        decreases measureGenerations
    {

        //@vdm.function.body
        var new_p: Population :| new_p == generation(pop);
        if (n == 1) then
            [new_p]
        else
            ([new_p] + generations((n - 1), new_p))
    }


    //@vdm.function(`measureGenerations`)
    function measureGenerations(n: vdm.nat1, arg0: Population): nat
    {
        //@vdm.function.body
        n as nat
    }


    //@vdm.function(`offset`)
    function offset(pop: Population, dx: int, dy: int): Population
    {

        //@vdm.function.body
        (set x: int, y: int | Point.mk_Point(x, y) in pop :: mk_Point((x + dx), (y + dy)))
    }


    //@vdm.function(`isOffset`)
    predicate isOffset(pop1: Population, pop2: Population, max: vdm.nat1)
    {
        //@vdm.function.body
        exists dx: int, dy: int ::
            //@vdm.bindings
            dx in ((set vdmTmpRange | (-max as int) <= vdmTmpRange <= max as int :: vdmTmpRange)) && dy in ((set vdmTmpRange | (-max as int) <= vdmTmpRange <= max as int :: vdmTmpRange)) &&
            //@vdm.predicate
            (((dx != 0) || (dy != 0)) && (offset(pop1, dx, dy) == pop2))}


    //@vdm.function(`periodN`)
    predicate periodN(pop: Population, n: vdm.nat1)
    {
        //@vdm.function.body
        ((vdm.iterate(generation, n))(pop) == pop)}


    //@vdm.function(`disappearN`)
    predicate disappearN(pop: Population, n: vdm.nat1)
    {
        //@vdm.function.body
        ((vdm.iterate(generation, n))(pop) == {})}


    //@vdm.function(`gliderN`)
    predicate gliderN(pop: Population, n: vdm.nat1, max: vdm.nat1)
    {
        //@vdm.function.body
        isOffset(pop, (vdm.iterate(generation, n))(pop), max)}


    //@vdm.function(`periodNP`)
    predicate periodNP(pop: Population, n: vdm.nat1)
    {
        //@vdm.function.body
        ((set a: vdm.nat1 | periodN(pop, a) && a in ((set vdmTmpRange | 1 <= vdmTmpRange <= n :: vdmTmpRange)) :: a) == {n})}


    //@vdm.function(`disappearNP`)
    predicate disappearNP(pop: Population, n: vdm.nat1)
    {
        //@vdm.function.body
        ((set a: vdm.nat1 | disappearN(pop, a) && a in ((set vdmTmpRange | 1 <= vdmTmpRange <= n :: vdmTmpRange)) :: a) == {n})}


    //@vdm.function(`gliderNP`)
    predicate gliderNP(pop: Population, n: vdm.nat1, max: vdm.nat1)
    {
        //@vdm.function.body
        ((set a: vdm.nat1 | gliderN(pop, a, max) && a in ((set vdmTmpRange | 1 <= vdmTmpRange <= n :: vdmTmpRange)) :: a) == {n})}


    //@vdm.function(`tests`)
    function tests(): seq<bool>
    {

        //@vdm.function.body
        [periodNP(BLOCK, 1), periodNP(BLINKER, 2), periodNP(TOAD, 2), periodNP(BEACON, 2), periodNP(PULSAR, 3), gliderNP(GLIDER, 4, 1), disappearNP(DIEHARD, 130)]
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////     
    //////////////////////////////////////////// OPERATIONS ////////////////////////////////////////////     
    ////////////////////////////////////////////////////////////////////////////////////////////////////     

}