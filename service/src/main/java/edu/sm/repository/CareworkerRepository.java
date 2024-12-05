package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Careworker;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CareworkerRepository extends SMRepository<Integer, Careworker> {
    Careworker selectByUsername(String username) throws Exception;
    Careworker selectByTel(String tel) throws Exception;
    Careworker selectByEmail(String email) throws Exception;
    List<Careworker> selectNearbyCareworkers(Double latitude, Double longitude, Double radius) throws Exception;
    // 비밀번호 수정
    void updatePassword(Careworker careworker);
    // 사용자 상태를 inactive로 변경 (소프트 삭제)
    void deactivateCareworker(int CwId);
}
