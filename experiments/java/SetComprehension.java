
import java.util.Set;
import java.util.function.BiConsumer;
import java.util.function.BiFunction;
import java.util.function.BiPredicate;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class SetComprehension<T, R> 
{
    private SetComprehension()
    {
    }

    public Set<R> suchThat(final Consumer<Binding<T>> predicates, final Function<T, R> resultTransformer) 
    {
        final Binding<T> x = new Binding<T>();
        predicates.accept(x);
        return (Set<R>) x.value().stream().map(resultTransformer).collect(Collectors.toSet());
    }

    /**
     * Creates a set of values related to the given binding result type R. 
     * //TODO Perhaps have types T, S, R?
     * @param predicates
     * @param resultTransformer
     * @return
     */
    public Set<R> suchThat(final BiConsumer<Binding<T>, Binding<T>> predicates, final BiFunction<T, T, R> resultTransformer) 
    {
        final Binding<T> x = new Binding<T>();
        final Binding<T> y = new Binding<T>();
        predicates.accept(x, y);
        return (Set<R>) x.value(y).stream()
                .map(pair -> resultTransformer.apply(pair.getKey(), pair.getValue()))
                .collect(Collectors.toSet());
    }

    /**
     * { x | x in set s }
     * This corresponds to comprehension mapping over the identity function over x in s with predicate true for every x.
     * This also corresponds to the original set of course.  
     * @param <X> source type of elements of s
     * @param s, where s is a set of X
     * @return set of values x within s 
     */
    public static final <X> Set<X> comprehend(final Set<X> s) 
    {
        return comprehend(s, (Predicate<X>)(x -> true));
        //return s;
    }

    /**
     * { x | x in set s & P(x) }. 
     * This corresponds to comprehension mapping over the identity function over x in s 
     * @param <X> source type of elements of s
     * @param s, where s is a set of X
     * @param p, where p is a predicate on X
     * @return set of values x within s filtered by p 
     */
    public static final <X> Set<X> comprehend(final Set<X> s, final Predicate<X> p) 
    {
        return comprehend(Function.identity(), s, p);
    }

    /**
     * { e(x) | x in set s }
     * We flip the parameters to avoid ambiguitity with {@link #comprehend(Set, Predicate)}
     * @param <X> source type of elements of s
     * @param <Y> target type of elements of result
     * @param s, where s is a set of X
     * @param e, where e is a function from X to Y
     * @return set of values x within s mapped over e 
     */
    public static final <X, Y> Set<Y> comprehend(final Function<X, Y> e, final Set<X> s) 
    {
        return comprehend(e, s, (x -> true));
    }

    /**
     * { e(x) | x in set s & P(x) }
     * @param <X> source type of elements of s
     * @param <Y> target type of elements of result
     * @param s, where s is a set of X
     * @param p, where p is a predicate on X
     * @param e, where e is a function from X to Y
     * @return set of values x within s filtered by p mapped over e 
     */
    public static final <X, Y> Set<Y> comprehend(final Function<X, Y> e, final Set<X> s, final Predicate<X> p) 
    {
        return new SetComprehension<X, Y>()
                .suchThat(x -> {
                    x.belongsTo(s);
                    x.holds(p);
                }, e);
    }

    public static final <X> Set<Pair<X, X>> crossProduct(final Set<X> s1, final Set<X> s2) 
    {
        return crossProduct(s1, s2, (x,y) -> true);
    }

    public static final <X> Set<Pair<X, X>> crossProduct(final Set<X> s1, final Set<X> s2, final BiPredicate<X, X> p) 
    {
        return crossProduct(Pair.identity(), s1, s2, p);
    }

    // public static final <X> Set<Set<Pair<X, X>>> setProduct(final Set<X> s1, final Set<X> s2, final BiPredicate<X, X> p) 
    // {
    //     SetComprehension c = new SetComprehension<>();
    //     c.suchThat( (Set<Pair<X, X>>) x -> { } );
    // }

    public static final <X, Y> Set<Y> crossProduct(final BiFunction<X, X, Y> e, final Set<X> s1, final Set<X> s2, final BiPredicate<X, X> p) 
    {
        return new SetComprehension<X, Y>()
                .suchThat((x, y) -> {
                    x.belongsTo(s1);
                    y.belongsTo(s2);
                    x.holds(p);
                }, e);
    }

    // public static final <X, Y, R> Set<Pair<X, Y>> comprehend(final BiFunction<X, Y, R> e, final Set<X> s1, final Set<Y> s2, final BiPredicate<X, Y> p) 
    // {
    //     return new SetComprehension<X, Y>()
    //             .suchThat((x, y) -> {
    //                 x.belongsTo(s1);
    //                 y.belongsTo(s2);
    //                 x.holds(p);
    //             }, e);
    // }

    @SafeVarargs
    public static <T> Set<T> asSet(final T... t)
    {
        assert t != null;
        return Stream.of(t).filter(x -> x != null).collect(Collectors.toSet());
    }  

    public static final void assertEquals(Object expected, Object actual)
    {
        System.out.println("\nExpected = " + String.valueOf(expected) + 
                           "\nActual   = " + String.valueOf(actual));
        if (expected == null)
        { 
            if (actual != null) throw new AssertionError();
        }
        else  
        {
            if (!expected.equals(actual)) throw new AssertionError();
        }
    }

    public static void main(String[] args)
    {
        //{ x | x in set {1,2,3,4} & x is even } = {2,4}
        assertEquals(comprehend(asSet(1,2,3,4), x -> x % 2 == 0), asSet(2,4));
        //{ x * 2 | x in set {1,2,3,4} } = {2, 4, 6, 8}
        assertEquals(comprehend((x -> x * 2), asSet(1,2,3,4)), asSet(2, 4, 6, 8));
        //{ x * 2 | x in set {1,2,3,4} & x > 2 } = {6, 8}
        assertEquals(comprehend((x -> x * 2), asSet(1,2,3,4), (x -> x > 2)), asSet(6, 8));
        //{ (x,y) | x in set {1,2}, y in set {3,4} } = { (1,3), (1,4), (2,3), (2,4)}
        assertEquals(crossProduct(asSet(1,2), asSet(3,4)), asSet(Pair.of(1,3), Pair.of(1,4), Pair.of(2,3), Pair.of(2,4)));
        //{ (x,y) | x in set {1,2,3}, y in set {4,5,6} & x * 2 = y } = { (2,4), (3,6) }
        assertEquals(crossProduct(asSet(1,2,3), asSet(4,5,6), (x, y) -> x * 2 == y), asSet(Pair.of(2,4), Pair.of(3,6)));
        //{ { (x, y) | x in set {1, 2, 3} & x * 2 = y} | y in set {4,5,6,7} & y < 7 } = { {2,4}, {3,6}, {} }
        //TODO using setProduct etc? Examples commented above but not quite right
    }

    
}
