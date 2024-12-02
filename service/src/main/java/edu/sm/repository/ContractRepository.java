package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Contract;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ContractRepository extends SMRepository<Integer, Contract> {
    List<Contract> findAllByCareworkerId(@Param("cwId") Integer cwId);
    List<Contract> findByCareworkerIdAndStatus(@Param("cwId") Integer cwId, @Param("status") String status);
}
