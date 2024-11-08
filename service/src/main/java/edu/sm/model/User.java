package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private int userId;
    private String username;              // 사용자 아이디
    private String password;
    private String tel;
    private String email;
    private String name;
    private LocalDate birthday;
    private String zipcode;
    private String detailAdd1;            // 상세 주소 1
    private String detailAddr1;           // 상세 주소 2
    private String detailAddr2;           // 상세 주소 3
    private LocalDateTime regDate;        // 회원가입 일자
    private String status;
    private String profileImage;
}
