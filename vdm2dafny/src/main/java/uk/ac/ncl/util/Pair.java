package uk.ac.ncl.util;

public class Pair<T1, T2> {
    private T1 k;
    private T2 v;

    

    public Pair(T1 k, T2 v) {
        this.k = k;
        this.v = v;
    }

    public static <T1, T2> Pair<T1, T2> of(T1 k, T2 v) {
        return new Pair<>(k, v);
    }

    public T1 key() {
        return k;
    }

    public T2 value() {
        return v;
    }
    
    public T1 getKey() {
        return k;
    }

    public T2 getValue() {
        return v;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((k == null) ? 0 : k.hashCode());
        result = prime * result + ((v == null) ? 0 : v.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Pair other = (Pair) obj;
        if (k == null) {
            if (other.k != null)
                return false;
        } else if (!k.equals(other.k))
            return false;
        if (v == null) {
            if (other.v != null)
                return false;
        } else if (!v.equals(other.v))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Pair [k=" + k + ", v=" + v + "]";
    }
}
