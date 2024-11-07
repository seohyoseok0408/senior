package edu.sm.service;

import edu.sm.model.User;
import edu.sm.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserService {
    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void registerUser(User user) throws Exception {
        // 회원가입일자 설정
        user.setRegDate(LocalDateTime.now());
        // 사용자 데이터 저장
        userRepository.insert(user);
    }

    public User getUserById(int userId) throws Exception {
        // 특정 userId에 해당하는 User 정보를 가져옴
        return userRepository.selectOne(userId);
    }

    private void validateUser(User user) {
        // 유효성 검사 코드 (생략)
    }
}
