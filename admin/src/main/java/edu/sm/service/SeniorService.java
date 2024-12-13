package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.HealthInfo;
import edu.sm.model.Senior;
import edu.sm.repository.SeniorRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class SeniorService implements SMService<Integer, Senior> {
    private final StandardPBEStringEncryptor textEncoder;

    private final SeniorRepository seniorRepository;

    @Override
    public void add(Senior senior) throws Exception {
        // 추가 기능 구현
    }

    @Override
    public void modify(Senior senior) throws Exception {
        if (senior.getSeniorId() == 0) {
            throw new IllegalArgumentException("Senior ID cannot be zero.");
        }
        seniorRepository.update(senior);
    }

    @Override
    public void del(Integer integer) throws Exception {
        // 삭제 기능 구현
    }

    @Override
    public Senior get(Integer integer) throws Exception {
        Senior senior = seniorRepository.selectOne(integer);
        decryptAddress(senior);
        return senior;
    }

    @Override
    public List<Senior> get() throws Exception {
        List<Senior> seniors = seniorRepository.findAll();

        for (Senior senior : seniors) {
            decryptAddress(senior); // 주소 복호화
        }
        log.info(seniors.toString());
        return seniors;
    }

    // 지역별 인원 수 조회 메서드 추가
    public List<Map<String, Object>> getRegionWisePersonCount() {
        List<Map<String, Object>> regionWiseCount = seniorRepository.getRegionWisePersonCount();
        if (regionWiseCount.isEmpty()) {
            log.warn("No data found for region-wise person count");
        }
        return regionWiseCount;
    }

    public List<Map<String, Object>> getAgeGroupDistribution() {
        List<Map<String, Object>> ageGroupDistribution = seniorRepository.getSeniorAgeGroupDistribution();

        if (ageGroupDistribution.isEmpty()) {
            log.warn("No age group distribution data found in the senior table.");
        }

        return ageGroupDistribution;
    }

    private void decryptAddress(Senior senior) {
        if (senior.getSeniorStreetAddr() != null) {
            senior.setSeniorStreetAddr(textEncoder.decrypt(senior.getSeniorStreetAddr()));
        }
        if (senior.getSeniorDetailAddr1() != null) {
            senior.setSeniorDetailAddr1(textEncoder.decrypt(senior.getSeniorDetailAddr1()));
        }
        if (senior.getSeniorDetailAddr2() != null) {
            senior.setSeniorDetailAddr2(textEncoder.decrypt(senior.getSeniorDetailAddr2()));
        }
    }

    // 기존 메서드들 유지
    public void modifyById(Integer id, Senior updatedSenior) throws Exception {
        Senior existingSenior = seniorRepository.selectOne(id);
        if (existingSenior == null) {
            throw new IllegalArgumentException("Senior not found with ID: " + id);
        }

        // 필드 병합: null이 아닌 값만 업데이트
        if (updatedSenior.getSeniorName() != null) {
            existingSenior.setSeniorName(updatedSenior.getSeniorName());
        }
        if (updatedSenior.getSeniorTel() != null) {
            existingSenior.setSeniorTel(updatedSenior.getSeniorTel());
        }
        if (updatedSenior.getSeniorBirth() != null) {
            existingSenior.setSeniorBirth(updatedSenior.getSeniorBirth());
        }
        if (updatedSenior.getSeniorZipcode() != null) {
            existingSenior.setSeniorZipcode(updatedSenior.getSeniorZipcode());
        }
        if (updatedSenior.getSeniorStreetAddr() != null) {
            existingSenior.setSeniorStreetAddr(updatedSenior.getSeniorStreetAddr());
        }
        if (updatedSenior.getSeniorDetailAddr1() != null) {
            existingSenior.setSeniorDetailAddr1(updatedSenior.getSeniorDetailAddr1());
        }
        if (updatedSenior.getSeniorDetailAddr2() != null) {
            existingSenior.setSeniorDetailAddr2(updatedSenior.getSeniorDetailAddr2());
        }
        if (updatedSenior.getSeniorStatus() != null) {
            existingSenior.setSeniorStatus(updatedSenior.getSeniorStatus());
        }
        if (updatedSenior.getSeniorSignificant() != null) {
            existingSenior.setSeniorSignificant(updatedSenior.getSeniorSignificant());
        }

        seniorRepository.update(existingSenior); // 병합된 데이터를 DB에 저장
    }

    public List<HealthInfo> getHealthInfoBySeniorId(Integer seniorId) throws Exception {
        if (seniorId == null || seniorId <= 0) {
            throw new IllegalArgumentException("Invalid senior ID: " + seniorId);
        }
        List<HealthInfo> healthInfoList = seniorRepository.findHealthInfoBySeniorId(seniorId);
        if (healthInfoList.isEmpty()) {
            log.warn("No health information found for senior ID: {}", seniorId);
        }
        return healthInfoList;
    }

    public Map<String, Object> getRecentContractInfo(Integer seniorId) {
        Map<String, Object> recentContractInfo = seniorRepository.findRecentContractInfoBySeniorId(seniorId);

        // null 값을 기본값으로 처리
        if (recentContractInfo == null || recentContractInfo.isEmpty()) {
            recentContractInfo = Map.of(
                    "userId", "",
                    "userName", "정보 없음",
                    "careworkerId", "",
                    "careworkerName", "정보 없음"
            );
        }
        return recentContractInfo;
    }

    public Long getTotalContractAmount(Integer seniorId) {
        Long totalAmount = seniorRepository.selectTotalContractAmountByseniorId(seniorId);

        // null 값을 0으로 처리
        return totalAmount != null ? totalAmount : 0L;
    }

    public Long getContractRenewalCount(Integer seniorId) {
        Long renewalCount = seniorRepository.selectContractRenewalCountByseniorId(seniorId);

        // null 값을 0으로 처리
        return renewalCount != null ? renewalCount : 0L;
    }



}
