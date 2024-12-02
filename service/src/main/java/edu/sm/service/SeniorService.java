package edu.sm.service;

import edu.sm.util.FileUploadUtil;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import edu.sm.repository.SeniorRepository;
import edu.sm.frame.SMService;
import edu.sm.model.Senior;
import lombok.RequiredArgsConstructor;

import java.nio.file.Paths;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class SeniorService implements SMService<Integer, Senior> {
    private final SeniorRepository seniorRepository;
    private final StandardPBEStringEncryptor textEncoder;

    @Value("${app.dir.uploaddir}")
    String imgDir;

    @Override
    public void add(Senior senior) throws Exception {
        String seniorDir = Paths.get(imgDir, "senior").toString();

        encryptAddress(senior);

        FileUploadUtil.saveFile(senior.getSeniorProfileFile(), seniorDir);

        senior.setSeniorStatus("active");
        seniorRepository.insert(senior);
    }

    @Override
    public Senior get(Integer seniorId) throws Exception {
        Senior senior = seniorRepository.selectOne(seniorId);
        decryptAddress(senior); // 조회 시 주소 복호화
        return senior;
    }

    @Override
    public List<Senior> get() throws Exception {
        return null;
    }

    @Override
    public void modify(Senior senior) throws Exception {}

    @Override
    public void modifyById(Integer id, Senior updatedSenior) throws Exception {
        Senior senior = seniorRepository.selectOne(id);
        if (senior == null) {
            throw new IllegalArgumentException("Senior not found with ID: " + id);
        }

        if (updatedSenior.getSeniorName() != null) {
            senior.setSeniorName(updatedSenior.getSeniorName());
        }
        if (updatedSenior.getSeniorStreetAddr() != null) {
            senior.setSeniorStreetAddr(updatedSenior.getSeniorStreetAddr());
        }
        if (updatedSenior.getSeniorDetailAddr1() != null) {
            senior.setSeniorDetailAddr1(updatedSenior.getSeniorDetailAddr1());
        }
        if (updatedSenior.getSeniorDetailAddr2() != null) {
            senior.setSeniorDetailAddr2(updatedSenior.getSeniorDetailAddr2());
        }

        encryptAddress(senior); // 수정된 주소 암호화하여 저장
        seniorRepository.update(senior);
    }

    @Override
    public void del(Integer seniorId) throws Exception {
        throw new IllegalArgumentException("삭제는 불가합니다.");
    }

    public void updateStatusToInactive(Integer seniorId) throws Exception {
        Senior senior = seniorRepository.selectOne(seniorId);
        if (senior == null) {
            throw new IllegalArgumentException("Senior not found with ID: " + seniorId);
        }

        senior.setSeniorStatus("inactive");
        seniorRepository.update(senior);
    }

    public Senior getSeniorsByUserId(Integer userId) throws Exception {
        Senior senior = seniorRepository.selectSeniorsByUserId(userId);
        decryptAddress(senior);
        return senior;
    }

    private void encryptAddress(Senior senior) {
        if (senior.getSeniorStreetAddr() != null) {
            senior.setSeniorStreetAddr(textEncoder.encrypt(senior.getSeniorStreetAddr()));
        }
        if (senior.getSeniorDetailAddr1() != null) {
            senior.setSeniorDetailAddr1(textEncoder.encrypt(senior.getSeniorDetailAddr1()));
        }
        if (senior.getSeniorDetailAddr2() != null) {
            senior.setSeniorDetailAddr2(textEncoder.encrypt(senior.getSeniorDetailAddr2()));
        }
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
}