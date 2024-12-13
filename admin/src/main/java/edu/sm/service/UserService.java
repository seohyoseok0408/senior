package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Senior;
import edu.sm.model.User;
import edu.sm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService implements SMService<Integer, User> {

    private final UserRepository userRepository;
    private final StandardPBEStringEncryptor textEncoder;

    @Override
    public void add(User user) throws Exception {
        // 구현 필요 시 추가
    }

    @Override
    public void modify(User user) throws Exception {
        if (user.getUserId() == 0) {
            throw new IllegalArgumentException("User ID cannot be zero.");
        }
        userRepository.update(user);
    }

    @Override
    public void del(Integer integer) throws Exception {
        // 구현 필요 시 추가
    }

    @Override
    public User get(Integer integer) throws Exception {
        User user = userRepository.selectOne(integer);
        decryptAddress(user);

        return user;
    }

    @Override
    public List<User> get() throws Exception {
        List<User> users = userRepository.findAll();
        for (User user : users) {
            decryptAddress(user);
        }
        return users;
    }

    public void modifyById(Integer id, User updatedUser) throws Exception {
        User existingUser = userRepository.selectOne(id);
        if (existingUser == null) {
            throw new IllegalArgumentException("User not found with ID: " + id);
        }

        // 기존 필드와 새 필드 병합
        if (updatedUser.getUserEmail() != null) {
            existingUser.setUserEmail(updatedUser.getUserEmail());
        }
        if (updatedUser.getUserTel() != null) {
            existingUser.setUserTel(updatedUser.getUserTel());
        }
        if (updatedUser.getUserName() != null) {
            existingUser.setUserName(updatedUser.getUserName());
        }
        if (updatedUser.getUserZipcode() != null) {
            existingUser.setUserZipcode(updatedUser.getUserZipcode());
        }
        if (updatedUser.getUserStreetAddr() != null) {
            existingUser.setUserStreetAddr(updatedUser.getUserStreetAddr());
        }
        if (updatedUser.getUserDetailAddr1() != null) {
            existingUser.setUserDetailAddr1(updatedUser.getUserDetailAddr1());
        }
        if (updatedUser.getUserDetailAddr2() != null) {
            existingUser.setUserDetailAddr2(updatedUser.getUserDetailAddr2());
        }
        if (updatedUser.getUserStatus() != null) {
            existingUser.setUserStatus(updatedUser.getUserStatus());
        }
        if (updatedUser.getUserProfile() != null) {
            existingUser.setUserProfile(updatedUser.getUserProfile());
        }

        userRepository.update(existingUser); // 병합된 데이터를 DB에 저장
    }

    public List<Senior> getSeniorsByUserId(Integer userId) throws Exception {
        return userRepository.selectSeniorByUserId(userId);
    }

    // 사용자 상태를 inactive로 변경하는 메서드
    public void updateStatusToInactive(Integer userId) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("User not found with ID: " + userId);
        }
        user.setUserStatus("inactive");
        userRepository.update(user);
    }

    // 월별 회원 가입 통계 조회
    public List<Map<String, Object>> getMonthlySignupStats() {
        return userRepository.selectMonthlySignupStats();
    }

    // 유저 상태별 카운트 조회
    public List<Map<String, Object>> getUserStatusCount() {
        return userRepository.selectUserStatusCount();
    }

    // 유저별 계약 금액 조회
    public Long getTotalContractAmountByUserId(Integer userId) {
        return userRepository.selectTotalContractAmountByUserId(userId);
    }

    // 유저별 시니어 수 조회
    public Long getSeniorCountByUserId(Integer userId) {
        return userRepository.selectSeniorCountByUserId(userId);
    }

    // 계약 갱신 빈도 조회
    public Long getContractRenewalCountByUserId(Integer userId) {
        return userRepository.selectContractRenewalCountByUserId(userId);
    }



    private void decryptAddress(User user) {
        if (user.getUserStreetAddr() != null) {
            user.setUserStreetAddr(textEncoder.decrypt(user.getUserStreetAddr()));
        }
        if (user.getUserDetailAddr1() != null) {
            user.setUserDetailAddr1(textEncoder.decrypt(user.getUserDetailAddr1()));
        }
        if (user.getUserDetailAddr2() != null) {
            user.setUserDetailAddr2(textEncoder.decrypt(user.getUserDetailAddr2()));
        }
    }
}
