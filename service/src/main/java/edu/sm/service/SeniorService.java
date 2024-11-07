package edu.sm.service;

import edu.sm.model.Senior;
import edu.sm.repository.SeniorRepository;
import edu.sm.frame.SMService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
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
        if (senior.getSeniorId() == 0) {
            throw new IllegalArgumentException("Senior ID cannot be zero.");
        }
        seniorRepository.update(senior); // Senior 객체를 사용하여 업데이트
    }

    @Override
    public void del(Integer seniorId) throws Exception {
        throw new IllegalArgumentException("삭제는 불가합니다.");
    }

    @Override
    public Senior get(Integer seniorId) throws Exception {
        return seniorRepository.selectOne(seniorId);
    }

    @Override
    public List<Senior> get() throws Exception {
        return seniorRepository.select();
    }

    public void updateStatusToInactive(Integer seniorId) throws Exception {
        seniorRepository.updateStatusToInactive(seniorId);
    }
}
