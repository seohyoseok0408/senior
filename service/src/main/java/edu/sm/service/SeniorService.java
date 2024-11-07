package edu.sm.service;

import edu.sm.model.Senior;
import edu.sm.repository.SeniorRepository;
import edu.sm.frame.SMService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SeniorService implements SMService<Integer, Senior> {

    private final SeniorRepository seniorRepository;

    @Override
    public void add(Senior senior) throws Exception {
        seniorRepository.insert(senior);
    }

    @Override
    public void modify(Senior senior) throws Exception {
        seniorRepository.update(senior);
    }

    @Override
    public void del(Integer seniorId) throws Exception {
        seniorRepository.updateStatusToInactive(seniorId);
    }

    @Override
    public Senior get(Integer seniorId) throws Exception {
        return seniorRepository.selectOne(seniorId);
    }

    @Override
    public List<Senior> get() throws Exception {
        return seniorRepository.select();
    }
}
