package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Admin;
import edu.sm.repository.AdminRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminService implements SMService<Integer, Admin> {

    private final AdminRepository adminRepository;
    private final BCryptPasswordEncoder encoder;

    @Override
    public void add(Admin admin) throws Exception {
        validateAdminFields(admin); // 유효성 검사(username, password, name)

        if (adminRepository.findByUsername(admin.getAdminUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 사용자 아이디입니다.");
        }

        String rawPassword = admin.getAdminPassword();
        String encPassword = encoder.encode(rawPassword);
        admin.setAdminPassword(encPassword);

        adminRepository.insert(admin);
    }

    @Override
    public void modify(Admin admin) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public Admin get(Integer integer) throws Exception {
        return adminRepository.selectOne(integer);
    }

    @Override
    public List<Admin> get() throws Exception {
        return List.of();
    }

    public Admin getByUsername (String s) throws Exception {
        return adminRepository.findByUsername(s);
    }

    // 필수 필드 유효성 검사를 위한 메서드
    private void validateAdminFields(Admin admin) {
        if (admin.getAdminUsername() == null || admin.getAdminUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 이름은 필수 입력 항목입니다.");
        }
        if (admin.getAdminPassword() == null || admin.getAdminPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("비밀번호는 필수 입력 항목입니다.");
        }
        if (admin.getAdminName() == null || admin.getAdminName().trim().isEmpty()) {
            throw new IllegalArgumentException("이름은 필수 입력 항목입니다.");
        }
    }
}
