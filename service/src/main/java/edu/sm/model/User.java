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
    private String username;
    private String password;
    private String tel;
    private String email;
    private String name;
    private LocalDate birthday;
    private String zipcode;
    private String detailAdd1;       // "user_detail_add1"와 매핑
    private String detailAddr1;      // "user_detail_addr1"와 매핑
    private String detailAddr2;      // "user_detail_addr2"와 매핑
    private LocalDateTime regDate;
    private String status;
    private String profileImage;
}

