package edu.sm.service;

import edu.sm.model.Schedule;
import edu.sm.repository.CalendarRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class CalendarService {

    private final CalendarRepository calendarRepository;

    public List<Schedule> getSchedulesByUserId(int userId) {
        log.info("Fetching schedules for userId: {}", userId);
        return calendarRepository.selectSchedulesByUserId(userId);
    }

    public List<Schedule> getSchedulesByCwId(int cwId) {
        log.info("Fetching schedules for cwId: {}", cwId);
        return calendarRepository.selectSchedulesByCwId(cwId);
    }
}
