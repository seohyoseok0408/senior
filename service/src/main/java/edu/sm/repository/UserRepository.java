package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserRepository extends SMRepository<Integer, User> {
    User findByUsername(String username);
    User findByTel(String tel);
    User findByEmail(String email);
}
