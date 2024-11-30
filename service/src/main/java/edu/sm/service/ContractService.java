package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Contract;
import edu.sm.repository.ContractRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ContractService implements SMService<Integer, Contract> {
    private final ContractRepository contractRepository;

    @Override
    public void add(Contract contract) throws Exception {
        contract.setContractStatus("pending");

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
}
