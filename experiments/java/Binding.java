
import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.function.BiPredicate;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class Binding<V> 
{
    private final Set<V> belongsTo;
    private final Set<Predicate<V>> predicates;
    private final Set<BiPredicate<V, V>> biPredicates;

    Binding() {
        this.belongsTo = new HashSet<>();
        this.predicates = new HashSet<>();
        this.biPredicates = new HashSet<>();
        this.predicates.add(x -> true);
        this.biPredicates.add((x, y) -> true);
    }

    public Binding<V> belongsTo(final Set<V> c) 
    {
        this.belongsTo.addAll(c);
        return this;
    }

    public Binding<V> is(final Predicate<V> p) 
    {
        this.predicates.add(p);
        return this;
    }

    public Binding<V> holds(final Predicate<V> p)
    {
        return is(p);
    }

    public Binding<V> is(final BiPredicate<V, V> p) 
    {
        this.biPredicates.add(p);
        return this;
    }

    public Binding<V> holds(final BiPredicate<V, V> p) 
    {
        return is(p);
    }

    public List<V> value() 
    {
        return intersect(predicates.stream()
                .map(condition -> belongsTo.stream().filter(condition).collect(Collectors.toList()))
                .collect(Collectors.toList()));
    }

    private List<V> intersect(final List<List<V>> lists) 
    {
        return belongsTo.stream()
                .filter(x -> lists.stream().filter(list -> list.contains(x)).count() == lists.size())
                .collect(Collectors.toList());
    }

    public List<Pair<V, V>> value(final Binding<V> yVar) 
    {
        final List<BiPredicate<V, V>> allBiPredicates = new LinkedList<>();
        allBiPredicates.addAll(this.biPredicates);
        allBiPredicates.addAll((Collection<? extends BiPredicate<V, V>>) yVar.biPredicates.stream()
                .map(new Function<BiPredicate<V, V>, BiPredicate<V, V>>() {
                    @Override
                    public BiPredicate<V, V> apply(final BiPredicate<V, V> p) {
                        return new BiPredicate<V, V>() {
                            @Override
                            public boolean test(final V x, final V y) {
                                return p.test(y, x);
                            }
                        };
                    }
                }).collect(Collectors.toList()));

        final List<Pair<V, V>> pairs = new LinkedList<>();

        this.value().stream().map(new Function<V, Boolean>() {
            @Override
            public Boolean apply(final V x) {
                yVar.value().stream().map(new Function<V, Boolean>() {
                    @Override
                    public Boolean apply(final V y) {
                        return pairs.add(Pair.of(x, y));
                    }
                }).collect(Collectors.toList());
                return null;
            }
        }).collect(Collectors.toList());

        return pairs.stream().filter(pair -> holdsAll(allBiPredicates, pair)).collect(Collectors.toList());
    }

    public boolean holdsAll(final List<BiPredicate<V, V>> predicates, final Pair<V, V> pair) 
    {
        return predicates.stream().filter(p -> p.test(pair.getKey(), pair.getValue())).count() 
                == predicates.size();
    }
}