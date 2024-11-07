package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.User;
import edu.sm.repository.UserRepository;
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
public class UserService implements SMService<Integer, User> {
    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private static final String ALGORITHM = "AES";
    private static final byte[] KEY = "0123456789abcdef".getBytes(); // 16-byte key (주의: 실제로는 안전한 키 관리 필요)

    @Autowired
    public UserService(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void add(User user) throws Exception {
        registerUser(user);
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

    public void registerUser(User user) throws Exception {
        validateDuplicateUser(user);

        user.setRegDate(LocalDateTime.now());
        user.setPassword(passwordEncoder.encode(user.getPassword())); // 비밀번호 암호화

        // 주소 필드 암호화
        if (user.getDetailAdd1() != null) user.setDetailAdd1(encrypt(user.getDetailAdd1()));
        if (user.getDetailAddr1() != null) user.setDetailAddr1(encrypt(user.getDetailAddr1()));
        if (user.getDetailAddr2() != null) user.setDetailAddr2(encrypt(user.getDetailAddr2()));

        userRepository.insert(user);
    }

    public User getUserById(int userId) throws Exception {
        User user = userRepository.selectOne(userId);

//        // 주소 필드 복호화
//        if (user != null) {
//            if (user.getDetailAdd1() != null) user.setDetailAdd1(decrypt(user.getDetailAdd1()));
//            if (user.getDetailAddr1() != null) user.setDetailAddr1(decrypt(user.getDetailAddr1()));
//            if (user.getDetailAddr2() != null) user.setDetailAddr2(decrypt(user.getDetailAddr2()));
//        }
        return user;
    }

    // 암호화 메서드
    private String encrypt(String plainText) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        SecretKeySpec keySpec = new SecretKeySpec(KEY, ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, keySpec);
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    // 복호화 메서드
    private String decrypt(String encryptedText) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        SecretKeySpec keySpec = new SecretKeySpec(KEY, ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, keySpec);
        byte[] decodedBytes = Base64.getDecoder().decode(encryptedText);
        byte[] decryptedBytes = cipher.doFinal(decodedBytes);
        return new String(decryptedBytes);
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
