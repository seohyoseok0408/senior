package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Careworker;
import edu.sm.model.Contract;
import edu.sm.model.Schedule;
import edu.sm.model.Senior;
import edu.sm.repository.ContractRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    private final CareworkerService careworkerService;
    private final CalendarService calendarService;

    @Override
    public void add(Contract contract) throws Exception {
        contract.setContractStatus("PENDING");

        contractRepository.insert(contract);
    }

    @Override
    public void modify(Contract contract) throws Exception {
        contract.setContractStatus("ACTIVE");
        contractRepository.update(contract);
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

    public List<Map<String, Object>> getContractsWithDetails(Integer cwId, String status) throws Exception {
        // 보호사 정보 가져오기
        Careworker careworker = careworkerService.get(cwId);

        // 계약 목록 가져오기
        List<Contract> contracts = status.isEmpty()
                ? contractRepository.findAllByCareworkerId(cwId) // 전체 보기
                : contractRepository.findByCareworkerIdAndStatus(cwId, status); // 상태별 보기

        // Map으로 변환
        return contracts.stream().map(contract -> {
            Map<String, Object> data = new HashMap<>();
            data.put("contract", contract);

            try {
                // 시니어 정보와 고객 정보 추가
                Senior senior = seniorService.get(contract.getSeniorId());
                data.put("senior", senior);
                data.put("user", userService.get(contract.getUserId()));

                // 거리 계산 추가
                if (careworker.getCwLatitude() != null && careworker.getCwLongitude() != null &&
                        senior.getSeniorLatitude() != null && senior.getSeniorLongitude() != null) {
                    double distance = calculateDistance(
                            careworker.getCwLatitude(), careworker.getCwLongitude(),
                            senior.getSeniorLatitude(), senior.getSeniorLongitude()
                    );
                    data.put("distance", String.format("%.2f KM", distance));
                } else {
                    data.put("distance", "정보 없음");
                }
            } catch (Exception e) {
                log.error("Error fetching contract details", e);
                throw new RuntimeException(e);
            }
            return data;
        }).collect(Collectors.toList());
    }

    public Map<String, Object> getContractDetails(Integer contractId) throws Exception {
        Contract contract = contractRepository.selectOne(contractId);
        Careworker careworker = careworkerService.get(contract.getCwId());
        if (contract == null) {
            throw new RuntimeException("Contract not found");
        }

        Map<String, Object> contractDetails = new HashMap<>();
        contractDetails.put("contract", contract);
        contractDetails.put("careworker", careworker);
        contractDetails.put("senior", seniorService.get(contract.getSeniorId()));
        contractDetails.put("user", userService.get(contract.getUserId()));

        return contractDetails;
    }

    // Haversine Formula
    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // Earth radius in kilometers
        double latDistance = Math.toRadians(lat2 - lat1);
        double lonDistance = Math.toRadians(lon2 - lon1);

        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c; // Distance in kilometers
    }

    @Transactional
    public void createContractAndSchedule(Contract contract, Schedule schedule) throws Exception {
        try {
            // 1. 계약 생성
            contract.setContractStatus("PENDING");
            contractRepository.insert(contract); // contract_id가 자동 설정됨
            log.info("Contract created with ID: {}", contract.getContractId());

            // 2. 스케줄 생성
            schedule.setContractId(contract.getContractId()); // 생성된 계약 ID 설정
            schedule.setScheduleStatus("WAITING"); // 스케줄 상태 설정
            calendarService.addContractSchedule(schedule); // 스케줄 삽입
            log.info("Schedule created for contract ID: {}", contract.getContractId());
        } catch (Exception e) {
            log.error("Error creating contract and schedule", e);
            throw e; // 트랜잭션 롤백
        }
    }
}
