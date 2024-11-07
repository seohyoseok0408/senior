package edu.sm.repository;

import edu.sm.model.Senior;
import edu.sm.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SeniorRepository extends SMRepository<Integer, Senior> {

    void update(Senior senior) throws Exception;

    // 시니어 상태만 inactive로 업데이트
    void updateStatusToInactive(@Param("seniorId") Integer seniorId) throws Exception;
}
