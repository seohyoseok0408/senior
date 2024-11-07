package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Integer userId;
    private String userUsername;
    private String userPassword;
    private String userTel;
    private String userEmail;
    private String userName;
    private String userBirthday;
    private String userZipcode;
    private String userDetailAdd1;
    private String userDetailAddr1;
    private String userDetailAddr2;
    private String userRdate;
    private String userStatus;
    private String userProfile;
}
