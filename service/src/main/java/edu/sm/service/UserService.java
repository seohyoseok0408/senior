package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.User;
import edu.sm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService implements SMService<Integer, User> {
    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final StandardPBEStringEncryptor textEncoder;

    @Override
    @Transactional
    public void add(User user) throws Exception {
        validateDuplicateUser(user);

        user.setRegDate(LocalDateTime.now());
        user.setPassword(passwordEncoder.encode(user.getPassword())); // 비밀번호 암호화

        // 주소 필드 암호화
        if (user.getDetailAdd1() != null) user.setDetailAdd1(textEncoder.encrypt(user.getDetailAdd1()));
        if (user.getDetailAddr1() != null) user.setDetailAddr1(textEncoder.encrypt(user.getDetailAddr1()));
        if (user.getDetailAddr2() != null) user.setDetailAddr2(textEncoder.encrypt(user.getDetailAddr2()));

        userRepository.insert(user);
    }

    @Override
    public void modify(User user) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public User get(Integer integer) throws Exception {
        return null;
    }

    @Override
    public List<User> get() throws Exception {
        return List.of();
    }

    public User getUserById(int userId) throws Exception {
        User user = userRepository.selectOne(userId);

        // 주소 필드 복호화
        if (user != null) {
            if (user.getDetailAdd1() != null) user.setDetailAdd1(textEncoder.decrypt(user.getDetailAdd1()));
            if (user.getDetailAddr1() != null) user.setDetailAddr1(textEncoder.decrypt(user.getDetailAddr1()));
            if (user.getDetailAddr2() != null) user.setDetailAddr2(textEncoder.decrypt(user.getDetailAddr2()));
        }
        return user;
    }



    private void validateDuplicateUser(User user) {
        if (userRepository.findByUsername(user.getUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 아이디입니다.");
        }
        if (userRepository.findByTel(user.getTel()) != null) {
            throw new IllegalArgumentException("이미 존재하는 전화번호입니다.");
        }
        if (userRepository.findByEmail(user.getEmail()) != null) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }
    }
}
