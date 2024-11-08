package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Admin;
import edu.sm.model.Senior;
import edu.sm.model.User;
import edu.sm.repository.AdminRepository;
import edu.sm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService implements SMService<Integer, User> {

    private final UserRepository userRepository;


    @Override
    public void add(User user) throws Exception {

    }

    @Override

    public void modify(User user) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public User get(Integer integer) throws Exception {
        return userRepository.selectOne(integer);
    }

    @Override
    public List<User> get() throws Exception {
        return userRepository.findAll();
    }

    @Override
    public void modifyById(Integer integer, User user) throws Exception {
        SMService.super.modifyById(integer, user);
    }
    // userId로 senior 데이터 조회
    public List<Senior> getSeniorsByUserId(Integer userId) throws Exception {
        return userRepository.selectSeniorByUserId(userId);
    }
}
