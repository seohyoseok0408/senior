package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AdminRepository extends SMRepository<Integer, Admin> {
    Admin selectByUsername(String username) throws Exception;
}
