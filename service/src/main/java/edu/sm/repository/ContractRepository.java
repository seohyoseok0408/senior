package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Contract;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ContractRepository extends SMRepository<Integer, Contract> {
}
