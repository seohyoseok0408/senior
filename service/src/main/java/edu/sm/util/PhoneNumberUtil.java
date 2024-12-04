package edu.sm.util;

public class PhoneNumberUtil {
    public static String formatPhoneNumber(String phoneNumber) {
        if (phoneNumber.startsWith("+82")) {
            // '+82'를 '0'으로 대체
            phoneNumber = "0" + phoneNumber.substring(3).replaceAll(" ", "").replaceAll("-", "");
        } else {
            // 공백과 '-' 제거
            phoneNumber = phoneNumber.replaceAll(" ", "").replaceAll("-", "");
        }
        return phoneNumber;
    }
}
