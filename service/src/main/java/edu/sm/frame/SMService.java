package edu.sm.frame;

import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface SMService<K,V> {
    @Transactional
    void add(V v) throws Exception;
    @Transactional
    void modify(V v) throws Exception;
    @Transactional
    void del(K k) throws Exception;
    @Transactional(readOnly = true) 
    V get(K k) throws Exception;
    @Transactional(readOnly = true)
    List<V> get() throws Exception;
    @Transactional
    default void modifyById(K k, V v) throws Exception {
    }
}
