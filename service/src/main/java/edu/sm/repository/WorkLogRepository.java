package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.WorkLog;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Mapper
public interface WorkLogRepository extends SMRepository<Integer, WorkLog> {
    @Transactional
    List<WorkLog> selectBySeniorId(Integer seniorId) throws Exception;
}
