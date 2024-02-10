
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.function.BiFunction;

/**
 *   
 * @author Leo Freitas
 * @date 2023
 * @version 1.0
 */
public class Pair<K, V> {

    private final K key;
    private final V value;

    public final K getKey() { return key; }
    public final V getValue() { return value; } 

    private Pair(final K key, final V value) {
        if (key == null || value == null)
            throw new IllegalArgumentException("Neither key nor value can be null");
        this.key = key;
        this.value = value;
    }

    @Override
    public String toString() {
        return String.format("(%1$s, %2$s) ", String.valueOf(key), String.valueOf(value));
    }

    @Override
    public final int hashCode() {
        return (31 * key.hashCode()) + value.hashCode();
    }

    @SuppressWarnings("unchecked")
    @Override
    public final boolean equals(final Object o) {
        boolean result = false;
        if (this == o)
            result = true;
        else if (o instanceof Pair) {
            final Pair<K,V> pair = (Pair<K,V>) o;
            result = key.equals(pair.key) && value.equals(pair.value);
        }
        return result;
    }

    public static final <K, V> Pair<K, V> of(K k, V v)
    {
        return new Pair<K, V>(k, v);
    }

    public static final <K, V> BiFunction<K, V, Pair<K, V>> identity()
    {
        return (x, y) -> of(x, y);
    }

    public static final boolean sortable(Collection<?> c)
    {
        return !c.isEmpty() && c.iterator().next() instanceof Comparable;
    }

    /**
     * Produces a (possibly sorted) map from the given list of pairs, where duplicate keys get overriden by subsequent keys
     * @param <K> map / pair key type
     * @param <V> map / pair value type
     * @param l list of pairs
     * @param strict whether the key must be unique
     * @return map made from pairs
     */
    //TODO study/figure out if useful Collectors.groupByConcurrentMap? 
    public static final <K, V> Map<K, V> map_of(final List<Pair<K, V>> l, final boolean strict)
    {
        assert l != null;
        if (strict && l.stream().map(p -> p.key).distinct().count() != l.size())
            throw new IllegalArgumentException("List of pairs does not have unique keys");

            //TODO figure out with streams later
        //List<V> v = l.stream().map(p -> p.value).collect(Collectors.toList());
        //Map<K, List<V>> result = l.stream().collect(Collectors.groupingBy(p -> p.key, Collectors.mapping(p -> p.value, Collectors.toList())));
        // Map<K, V> result = l.stream().collect(Collectors.toMap(
        //     l.stream().map(p -> p.key).collect(Collectors.toList())::get, 
        //     l.stream().map(p -> p.value).collect(Collectors.toList())::get));
        final Map<K, V> result = sortable(l) ? new TreeMap<K, V>() : new HashMap<K, V>(); 
        for(final Pair<K, V> p : l)
        {
            result.put(p.key, p.value); 
        }
        return result;
    }

    public static final <K, V> Map<K, V> map_of(final List<Pair<K, V>> l)
    {
        return map_of(l, false);
    }

    @SafeVarargs
    public static final <K, V> Map<K, V> map_of(final Pair<K, V>... l)
    {
        return map_of(Arrays.asList(l));
    }

    public static final <K, V> Map<K, V> strict_map_of(final List<Pair<K, V>> l)
    {
        assert l != null;
        return map_of(l, true);
    } 

    @SafeVarargs
    public static final <K, V> Map<K, V> strict_map_of(final Pair<K, V>... l)
    {
        return strict_map_of(Arrays.asList(l));
    }
}