package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Schedule;
import edu.sm.repository.CalendarRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class CalendarService implements SMService<Integer, Schedule> {

    private final CalendarRepository calendarRepository;

    public List<Schedule> getSchedulesByUserId(int userId) {
        log.info("Fetching schedules for userId: {}", userId);
        return calendarRepository.selectSchedulesByUserId(userId);
    }

    public List<Schedule> getSchedulesByCwId(int cwId) {
        log.info("Fetching schedules for cwId: {}", cwId);
        return calendarRepository.selectSchedulesByCwId(cwId);
    }

    @Override
    public void add(Schedule schedule) throws Exception {
        try {
            schedule.setScheduleStatus("ACTIVE");
            log.info("Adding schedule: {}", schedule);
            calendarRepository.insertSchedule(schedule); // Repository를 통해 삽입
            log.info("Schedule added successfully");
        } catch (Exception e) {
            log.error("Failed to add schedule: {}", e.getMessage());
            throw new Exception("Error adding schedule", e);
        }
    }

    @Override
    public void modify(Schedule schedule) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public Schedule get(Integer integer) throws Exception {
        return null;
    }

    @Override
    public List<Schedule> get() throws Exception {
        return List.of();
    }

    @Override
    public void modifyById(Integer integer, Schedule schedule) throws Exception {
        SMService.super.modifyById(integer, schedule);
    }
}
