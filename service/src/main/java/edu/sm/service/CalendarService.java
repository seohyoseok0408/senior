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

    // userId로 일정 조회
    public List<Schedule> getSchedulesByUserId(int userId) {
        log.info("Fetching schedules for userId: {}", userId);
        return calendarRepository.selectSchedulesByUserId(userId);
    }

    // cwId로 일정 조회
    public List<Schedule> getSchedulesByCwId(int cwId) {
        log.info("Fetching schedules for cwId: {}", cwId);
        return calendarRepository.selectSchedulesByCwId(cwId);
    }

    // 계약과 관련 없는 일정 추가
    public void addNonContractSchedule(Schedule schedule) throws Exception {
        try {
            schedule.setScheduleStatus("ACTIVE");
            log.info("Adding non-contract schedule: {}", schedule);
            calendarRepository.insertNonContractSchedule(schedule);
            log.info("Non-contract schedule added successfully");
        } catch (Exception e) {
            log.error("Failed to add non-contract schedule: {}", e.getMessage());
            throw new Exception("Error adding non-contract schedule", e);
        }
    }

    // 계약과 관련된 일정 추가
    public void addContractSchedule(Schedule schedule) throws Exception {
        try {
            schedule.setScheduleStatus("ACTIVE");
            log.info("Adding contract-related schedule: {}", schedule);
            calendarRepository.insertContractSchedule(schedule);
            log.info("Contract-related schedule added successfully");
        } catch (Exception e) {
            log.error("Failed to add contract-related schedule: {}", e.getMessage());
            throw new Exception("Error adding contract-related schedule", e);
        }
    }

    @Override
    public void add(Schedule schedule) throws Exception {
        throw new UnsupportedOperationException("Use addNonContractSchedule or addContractSchedule instead.");
    }

    @Override
    public void modify(Schedule schedule) throws Exception {
        // 일정 수정 로직 구현 필요
    }

    @Override
    public void del(Integer id) throws Exception {
        // 일정 삭제 로직 구현 필요
    }

    @Override
    public Schedule get(Integer id) throws Exception {
        // 일정 상세 조회 로직 구현 필요
        return null;
    }

    @Override
    public List<Schedule> get() throws Exception {
        return List.of();
    }

    @Override
    public void modifyById(Integer id, Schedule schedule) throws Exception {
        SMService.super.modifyById(id, schedule);
    }
}
