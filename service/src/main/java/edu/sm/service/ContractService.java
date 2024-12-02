package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Contract;
import edu.sm.repository.ContractRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ContractService implements SMService<Integer, Contract> {
    private final ContractRepository contractRepository;
    private final SeniorService seniorService;
    private final UserService userService;

    @Override
    public void add(Contract contract) throws Exception {
        contract.setContractStatus("PENDING");

        contractRepository.insert(contract);
    }

    @Override
    public void modify(Contract contract) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public Contract get(Integer integer) throws Exception {
        return null;
    }

    @Override
    public List<Contract> get() throws Exception {
        return List.of();
    }

    public List<Map<String, Object>> getContractsWithDetails(Integer cwId, String status) throws Exception{
        // 조건에 따라 데이터 조회
        List<Contract> contracts = status.isEmpty()
                ? contractRepository.findAllByCareworkerId(cwId) // 전체 보기
                : contractRepository.findByCareworkerIdAndStatus(cwId, status); // 상태별 보기

        // Map으로 변환
        return contracts.stream().map(contract -> {
            Map<String, Object> data = new HashMap<>();
            data.put("contract", contract);
            try {
                data.put("senior", seniorService.get(contract.getSeniorId())); // 시니어 정보 추가
                data.put("user", userService.get(contract.getUserId()));       // 고객 정보 추가
            } catch (Exception e) {
                log.error("Error fetching contract details", e);
                throw new RuntimeException(e);
            }
            return data;
        }).collect(Collectors.toList());
    }

    public Map<String, Object> getContractDetails(Integer contractId) throws Exception {
        Contract contract = contractRepository.selectOne(contractId);
        if (contract == null) {
            throw new RuntimeException("Contract not found");
        }

        Map<String, Object> contractDetails = new HashMap<>();
        contractDetails.put("contract", contract);
        contractDetails.put("senior", seniorService.get(contract.getSeniorId()));
        contractDetails.put("user", userService.get(contract.getUserId()));

        return contractDetails;
    }

}
