package edu.sm.repository;

import edu.sm.model.Schedule;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CalendarRepository {
    // userId로 스케줄 조회
    List<Schedule> selectSchedulesByUserId(@Param("userId") int userId);

    // cwId로 스케줄 조회
    List<Schedule> selectSchedulesByCwId(@Param("cwId") int cwId);
}
