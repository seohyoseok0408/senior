package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.User;
import edu.sm.repository.UserRepository;
import edu.sm.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService implements SMService<Integer, User> {
    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final StandardPBEStringEncryptor textEncoder;

    @Value("${app.dir.uploaddir}")
    String imgDir;

    @Override
    @Transactional
    public void add(User user) throws Exception {
        String userDir = Paths.get(imgDir, "user").toString();

        validateDuplicateUser(user);

        if (user.getUserProfileFile() != null) {
            FileUploadUtil.saveFile(user.getUserProfileFile(), userDir);
        } else {
            log.info("프로필 이미지가 없습니다. 기본값(null)로 설정합니다.");
            user.setUserProfile(null);
        }

        user.setUserPassword(passwordEncoder.encode(user.getUserPassword())); // 비밀번호 암호화
        encryptAddressFields(user);

        user.setUserRegDate(LocalDateTime.now());
        user.setUserStatus("active");

        userRepository.insert(user);
    }

    @Override
    public void modify(User user) throws Exception {
    }

    @Override
    public void del(Integer userId) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }
        user.setUserStatus("inactive");
        userRepository.deactivateUser(userId);
    }

    @Transactional
    public void modifyById(Integer userId, User updatedUser) throws Exception {
        if (userId == null || userId <= 0) {
            throw new IllegalArgumentException("유효하지 않은 유저 ID입니다.");
        }

        // 기존 데이터 조회
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        // 수정 요청에서 제공된 값만 반영
        if (updatedUser.getUserTel() != null) {
            user.setUserTel(updatedUser.getUserTel());
        }
        if (updatedUser.getUserName() != null) {
            user.setUserName(updatedUser.getUserName());
        }
        if (updatedUser.getUserEmail() != null) {
            user.setUserEmail(updatedUser.getUserEmail());
        }
        if (updatedUser.getUserZipcode() != null) {
            user.setUserZipcode(updatedUser.getUserZipcode());
        }
        if (updatedUser.getUserStreetAddr() != null) {
            user.setUserStreetAddr(updatedUser.getUserStreetAddr());
        }
        if (updatedUser.getUserDetailAddr1() != null) {
            user.setUserDetailAddr1(updatedUser.getUserDetailAddr1());
        }
        if (updatedUser.getUserDetailAddr2() != null) {
            user.setUserDetailAddr2(updatedUser.getUserDetailAddr2());
        }
        if (updatedUser.getUserPassword() != null) {
            user.setUserPassword(passwordEncoder.encode(updatedUser.getUserPassword())); // 비밀번호 암호화
        }
        encryptAddressFields(user);
        // 변경된 데이터 저장
        userRepository.update(user);
    }

    // 비밀번호 수정
    @Transactional
    public void updatePassword(Integer userId, String newPassword) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        user.setUserPassword(passwordEncoder.encode(newPassword));

        userRepository.updatePassword(user);
    }

    @Override
    public User get(Integer userId) throws Exception {
        return getUserById(userId);
    }

    @Override
    public List<User> get() throws Exception {
        return null;
    }

    public User getUserById(int userId) throws Exception {
        User user = userRepository.selectOne(userId);

        decryptAddressFields(user); // 주소 필드 복호화
        return user;
    }

    @Transactional
    public User login(User user) throws Exception {
        User principal = userRepository.selectByUsername(user.getUserUsername());
        if (principal == null || !passwordEncoder.matches(user.getUserPassword(), principal.getUserPassword())) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다.");
        }

        if ("inactive".equalsIgnoreCase(principal.getUserStatus())) {
            throw new IllegalArgumentException("탈퇴된 계정은 로그인할 수 없습니다.");
        }

        return principal;
    }

    private void validateDuplicateUser(User user) {
        if (userRepository.findByUsername(user.getUserUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 아이디입니다.");
        }
        if (userRepository.findByTel(user.getUserTel()) != null) {
            throw new IllegalArgumentException("이미 존재하는 전화번호입니다.");
        }
        if (userRepository.findByEmail(user.getUserEmail()) != null) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }
    }

    // 이메일로 아이디 찾기
    public String findIdByEmail(String email) throws Exception {
        User user = userRepository.findByEmailForFindId(email);
        if (user == null) {
            throw new IllegalArgumentException("해당 이메일로 등록된 계정을 찾을 수 없습니다.");
        }

        String username = user.getUserUsername();

        // 아이디를 반으로 나누기
        int length = username.length();
        int halfLength = length / 2;

        // 앞부분: 반만 가져오기, 뒷부분: 나머지 부분은 *로 채우기
        String maskedUsername = username.substring(0, halfLength)
                + "*".repeat(length - halfLength);

        return maskedUsername;
    }

    public User getUsername(String username) throws Exception {
        return userRepository.selectByUsername(username);
    }

    // 주소 필드 암호화
    private void encryptAddressFields(User user) {
        if (user.getUserStreetAddr() != null) user.setUserStreetAddr(textEncoder.encrypt(user.getUserStreetAddr()));
        if (user.getUserDetailAddr1() != null) user.setUserDetailAddr1(textEncoder.encrypt(user.getUserDetailAddr1()));
        if (user.getUserDetailAddr2() != null) user.setUserDetailAddr2(textEncoder.encrypt(user.getUserDetailAddr2()));
    }

    // 주소 필드 복호화
    private void decryptAddressFields(User user) {
        if (user != null) {
            if (user.getUserStreetAddr() != null) user.setUserStreetAddr(textEncoder.decrypt(user.getUserStreetAddr()));
            if (user.getUserDetailAddr1() != null) user.setUserDetailAddr1(textEncoder.decrypt(user.getUserDetailAddr1()));
            if (user.getUserDetailAddr2() != null) user.setUserDetailAddr2(textEncoder.decrypt(user.getUserDetailAddr2()));
        }
    }
}
