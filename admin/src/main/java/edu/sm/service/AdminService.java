package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Admin;
import edu.sm.repository.AdminRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminService implements SMService<Integer, Admin> {

    private final AdminRepository adminRepository;

    @Override
    public void add(Admin admin) throws Exception {

    }

    @Override
    public void modify(Admin admin) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public Admin get(Integer integer) throws Exception {
        return adminRepository.selectOne(integer);
    }

    @Override
    public List<Admin> get() throws Exception {
        return List.of();
    }

    public Admin getByUsername (String s) throws Exception {
        return adminRepository.findByUsername(s);
    }
}
