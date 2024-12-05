package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Careworker;
import edu.sm.model.User;
import edu.sm.model.enums.CwStatus;
import edu.sm.repository.CareworkerRepository;
import edu.sm.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.file.Paths;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class CareworkerService implements SMService<Integer, Careworker> {

    private final CareworkerRepository careworkerRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final StandardPBEStringEncryptor textEncoder;

    @Value("${app.dir.uploaddir}")
    String imgDir;

    @Override
    public List<Careworker> get() throws Exception {
        return List.of();
    }

    @Override
    public Careworker get(Integer integer) throws Exception {
        Careworker careworker = careworkerRepository.selectOne(integer);
        decryptAddressFields(careworker); // 주소 필드 복호화
        return careworker;
    }

    @Override
    public void del(Integer cwId) throws Exception {
        Careworker careworker = careworkerRepository.selectOne(cwId);
        if (careworker == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + cwId);
        }
        careworkerRepository.deactivateCareworker(cwId);
    }

    @Override
    public void modify(Careworker careworker) throws Exception {

    }

    @Override
    public void add(Careworker careworker) throws Exception {
        String careworkerDir = Paths.get(imgDir, "careworker").toString();

        validateDuplicateUser(careworker);

        FileUploadUtil.saveFile(careworker.getCwProfileFile(), careworkerDir);

        careworker.setCwPassword(passwordEncoder.encode(careworker.getCwPassword()));
        encryptAddressFields(careworker);

        careworker.setCwStatus(CwStatus.WAITING);

        careworkerRepository.insert(careworker);
    }

    @Transactional
    public void modifyById(Integer cwId, Careworker updatedCareworker) throws Exception {
        log.info("수정 요청 ID: {}", cwId);
        log.info("수정 요청 데이터: {}", updatedCareworker);

        // 기존 데이터 조회
        Careworker careworker = careworkerRepository.selectOne(cwId);
        if (careworker == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + cwId);
        }
    // 수정 요청에서 제공된 값만 반영
        if (updatedCareworker.getCwTel() != null) {
            careworker.setCwTel(updatedCareworker.getCwTel());
        }
        if (updatedCareworker.getCwName() != null) {
            careworker.setCwName(updatedCareworker.getCwName());
        }
        if (updatedCareworker.getCwEmail() != null) {
            careworker.setCwEmail(updatedCareworker.getCwEmail());
        }
        if (updatedCareworker.getCwIntro() != null) {
            careworker.setCwIntro(updatedCareworker.getCwIntro());
        }
        if (updatedCareworker.getCwZipcode() != null) {
            careworker.setCwZipcode(updatedCareworker.getCwZipcode());
        }
        if (updatedCareworker.getCwStreetAddr() != null) {
            careworker.setCwStreetAddr(updatedCareworker.getCwStreetAddr());
        }
        if (updatedCareworker.getCwDetailAddr1() != null) {
            careworker.setCwDetailAddr1(updatedCareworker.getCwDetailAddr1());
        }
        if (updatedCareworker.getCwDetailAddr2() != null) {
            careworker.setCwDetailAddr2(updatedCareworker.getCwDetailAddr2());
        }
        if (updatedCareworker.getCwPassword() != null) {
            careworker.setCwPassword(passwordEncoder.encode(updatedCareworker.getCwPassword())); // 비밀번호 암호화
        }
        encryptAddressFields(careworker);
        // 변경된 데이터 저장
        careworkerRepository.update(careworker);
    }

    // 비밀번호 수정
    @Transactional
    public void updatePassword(Integer cwId, String newPassword) throws Exception {
        Careworker careworker = careworkerRepository.selectOne(cwId);
        if (careworker == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + cwId);
        }
        // 비밀번호를 암호화하여 Careworker 객체에 설정
        careworker.setCwPassword(passwordEncoder.encode(newPassword));

        // Careworker 객체를 업데이트
        careworkerRepository.updatePassword(careworker);
    }

    @Transactional
    public Careworker login(Careworker careworker) throws Exception {
        Careworker principal = careworkerRepository.selectByUsername(careworker.getCwUsername());
        if (principal == null || !passwordEncoder.matches(careworker.getCwPassword(), principal.getCwPassword())) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        if ("inactive".equalsIgnoreCase(String.valueOf(principal.getCwStatus()))) {
            throw new IllegalArgumentException("탈퇴된 계정은 로그인할 수 없습니다.");
        }
        return principal;
    }

    public List<Careworker> getCareworkersWithinRadius(double latitude, double longitude, double radius) throws Exception {
        return careworkerRepository.selectNearbyCareworkers(latitude, longitude, radius);
    }

    private void validateDuplicateUser(Careworker careworker) throws Exception {
        if (careworkerRepository.selectByUsername(careworker.getCwUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 아이디입니다.");
        }
        if (careworkerRepository.selectByTel(careworker.getCwTel()) != null) {
            throw new IllegalArgumentException("이미 존재하는 전화번호입니다.");
        }
        if (careworkerRepository.selectByEmail(careworker.getCwEmail()) != null) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }
    }

    private void encryptAddressFields(Careworker careworker) {
        if (careworker.getCwStreetAddr() != null)
            careworker.setCwStreetAddr(textEncoder.encrypt(careworker.getCwStreetAddr()));
        if (careworker.getCwDetailAddr1() != null)
            careworker.setCwDetailAddr1(textEncoder.encrypt(careworker.getCwDetailAddr1()));
        if (careworker.getCwDetailAddr2() != null)
            careworker.setCwDetailAddr2(textEncoder.encrypt(careworker.getCwDetailAddr2()));
    }

    private void decryptAddressFields(Careworker careworker) {
        if (careworker != null) {
            if (careworker.getCwStreetAddr() != null)
                careworker.setCwStreetAddr(textEncoder.decrypt(careworker.getCwStreetAddr()));
            if (careworker.getCwDetailAddr1() != null)
                careworker.setCwDetailAddr1(textEncoder.decrypt(careworker.getCwDetailAddr1()));
            if (careworker.getCwDetailAddr2() != null)
                careworker.setCwDetailAddr2(textEncoder.decrypt(careworker.getCwDetailAddr2()));
        }
    }
}
