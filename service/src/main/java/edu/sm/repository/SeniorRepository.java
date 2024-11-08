package edu.sm.repository;

import edu.sm.model.Senior;
import edu.sm.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SeniorRepository extends SMRepository<Integer, Senior> {

    void update(Senior senior) throws Exception;

}
