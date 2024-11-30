package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.WorkLog;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface WorkLogRepository extends SMRepository<Integer, WorkLog> {
}
