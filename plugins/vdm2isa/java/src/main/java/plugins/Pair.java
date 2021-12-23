package plugins;

import java.io.Serializable;

public class Pair<K, V> implements Serializable {

    private static final long serialVersionUID = 1L;

    public final K key;
    public final V value;

    public Pair(K key, V value) {
        if (key == null || value == null)
            throw new IllegalArgumentException("Key or value cannot be null");
        this.key = key;
        this.value = value;
    }

    @Override
    public String toString() {
        return String.valueOf(key) + "=" + String.valueOf(value);
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 31 * hash + key.hashCode();
        hash = 31 * hash + value.hashCode();
        return hash;
    }

    @SuppressWarnings("unchecked")
    @Override
    public boolean equals(Object o) {
        boolean result = false;
        if (this == o)
            result = true;
        else if (o instanceof Pair) {
            Pair<K,V> pair = (Pair<K,V>) o;
            result = key.equals(pair.key) && value.equals(pair.value);
        }
        return result;
    }
}