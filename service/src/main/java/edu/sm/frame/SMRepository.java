package edu.sm.frame;

import java.util.List;

public interface SMRepository<K,V> {
    void insert(V v) throws Exception;
    void update(V v) throws Exception;
    void delete(K k) throws Exception;
    V selectOne(K k) throws Exception;
    List<V> select() throws Exception;

}
