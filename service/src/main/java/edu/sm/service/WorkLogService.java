package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.WorkLog;
import edu.sm.repository.WorkLogRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class WorkLogService implements SMService<Integer, WorkLog> {
    private final WorkLogRepository workLogRepository;

    @Override
    public void add(WorkLog workLog) throws Exception {
        workLogRepository.insert(workLog);
    }

    @Override
    public void modify(WorkLog workLog) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public WorkLog get(Integer integer) throws Exception {
        return null;
    }

    @Override
    public List<WorkLog> get() throws Exception {
        return List.of();
    }
}
