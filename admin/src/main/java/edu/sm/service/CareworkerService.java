package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Careworker;
import edu.sm.model.License;
import edu.sm.repository.CareworkerRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class CareworkerService implements SMService<Integer, Careworker> {

    private final CareworkerRepository careworkerRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final StandardPBEStringEncryptor textEncoder;

    // 보호사 id로 자격증 목록 조회
    public List<License> getLicensesByCareworkerId(Integer cwId) throws Exception {
        return careworkerRepository.selectLicensesByCareworkerId(cwId);
    }

    // 보호사 상태를 waiting에서 active로 변경
    public void activateCareworker(Integer cwId) throws Exception {
        careworkerRepository.updateStatusFromWaitingToActive(cwId);
    }

    // 보호사 상태가 waiting인 보호사 목록 조회
    public List<Careworker> findWaiting() throws Exception {
        return careworkerRepository.findWaiting();
    }

    // 추가: 보호사와 자격증 데이터를 포함한 waiting 상태 보호사 목록 조회
    public List<Careworker> findWaitingWithLicenses() throws Exception {
        return careworkerRepository.findWaitingWithLicenses();
    }

    @Override
    public void add(Careworker careworker) throws Exception {
        if (careworkerRepository.selectByUsername(careworker.getCwUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 사용자 아이디입니다.");
        }

        // 비밀번호 암호화
        careworker.setCwPassword(passwordEncoder.encode(careworker.getCwPassword()));

        // 주소 필드 암호화
        if (careworker.getCwStreetAddr() != null) {
            careworker.setCwStreetAddr(textEncoder.encrypt(careworker.getCwStreetAddr()));
        }
        if (careworker.getCwDetailAddr1() != null) {
            careworker.setCwDetailAddr1(textEncoder.encrypt(careworker.getCwDetailAddr1()));
        }
        if (careworker.getCwDetailAddr2() != null) {
            careworker.setCwDetailAddr2(textEncoder.encrypt(careworker.getCwDetailAddr2()));
        }
        careworkerRepository.insert(careworker);
    }

    @Override
    public List<Careworker> get() throws Exception {
        List<Careworker> careworkers =careworkerRepository.findAll();
        for (Careworker careworker : careworkers) {
            decryptAddressFields(careworker);
        }
        return careworkers;
    }

    @Override
    public Careworker get(Integer integer) throws Exception {
        Careworker careworker = careworkerRepository.selectById(integer);
        decryptAddressFields(careworker);
        return careworker;
    }

    @Transactional
    public void modifyById(Integer cwId, Careworker careworker) {
        // 기존 Careworker 데이터 가져오기
        Careworker existing = careworkerRepository.selectById(cwId);
        if (existing == null) {
            throw new IllegalArgumentException("Careworker not found with id: " + cwId);
        }

        // 기존 데이터와 새로운 데이터를 병합하여 업데이트
        if (careworker.getCwTel() == null) careworker.setCwTel(existing.getCwTel());
        if (careworker.getCwEmail() == null) careworker.setCwEmail(existing.getCwEmail());
        if (careworker.getCwName() == null) careworker.setCwName(existing.getCwName());
        if (careworker.getCwZipcode() == null) careworker.setCwZipcode(existing.getCwZipcode());
        if (careworker.getCwStreetAddr() == null) careworker.setCwStreetAddr(existing.getCwStreetAddr());
        if (careworker.getCwDetailAddr1() == null) careworker.setCwDetailAddr1(existing.getCwDetailAddr1());
        if (careworker.getCwDetailAddr2() == null) careworker.setCwDetailAddr2(existing.getCwDetailAddr2());
        if (careworker.getCwStatus() == null) careworker.setCwStatus(existing.getCwStatus());
        if (careworker.getCwIntro() == null) careworker.setCwIntro(existing.getCwIntro());
        if (careworker.getCwExperience() == null) careworker.setCwExperience(existing.getCwExperience());

        // DB 업데이트
        careworkerRepository.update(careworker);
    }

    @Override
    public void del(Integer integer) throws Exception {
        // 실질적인 삭제 구현이 필요하다면 여기에 추가
    }

    @Override
    public void modify(Careworker careworker) throws Exception {
        // 실질적인 수정 구현이 필요하다면 여기에 추가
    }

    // 보호사의 상태별 인원 수 집계
    public List<Map<String, Object>> getCareworkerStatusCounts() {
        return careworkerRepository.selectCareworkerStatusCounts();
    }
    public List<Map<String, Object>> getMonthlyAverageRatings() {
        return careworkerRepository.findMonthlyAverageRatings();
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
