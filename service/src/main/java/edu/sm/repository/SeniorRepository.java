package edu.sm.repository;

import edu.sm.model.Senior;
import edu.sm.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.annotations.Update;

import java.util.List;
@Repository
@Mapper
public interface SeniorRepository extends SMRepository<Integer, Senior> {
    void updateStatusToInactive(@Param("seniorId") Integer seniorId) throws Exception;
}

