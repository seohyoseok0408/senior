package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserRepository extends SMRepository<Integer, User> {
    // SMRepository의 메서드들을 자동으로 상속 받습니다.
    // 추가적인 메서드가 필요하면 여기에 선언할 수 있습니다.
}
