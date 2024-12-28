# See Near

**Spring Boot 기반 시니어 실시간 건강 모니터링 시스템헬스케어 시스템 (WebSocket, AI Chatbot, WebRTC)**

**NOTION 주소**

[https://www.notion.so/SW-4-12a3aa17a00680ae8b39c5832ff89557](https://www.notion.so/SW-4-12a3aa17a00680ae8b39c5832ff89557?pvs=21)



**유튜브 주소**

[![See Near - Senior Health Monitoring System](http://img.youtube.com/vi/bZwnYCVVCLo/0.jpg)](https://youtu.be/bZwnYCVVCLo)


**👨🏻‍👩🏻‍👦🏻‍👦🏻MEMBER**

PL (Project Leader) : 서효석

DEV(Full stack): 조현열

DEV(Front end) : 이태빈

DEV(Back end) : 이동우, 진완규

기간: 2024.10.25~2024.12.20

# 1. 프로젝트 주제 및 기획의도


주제: 시니어의 건강 데이터 수집, 건강 정보 제공, 위험 상황 시 신속한 대응 지원


기획의도 

- 시니어들이 독립적인 생활을 유지하면서도 안전하게 지낼 수 있도록 지원
- 
- 보호자와 요양 보호사 간의 실시간 소통 및 관리 필요성 증대

차별화

- 웨어러블 기기를 도입해 실시간으로 건강 상태를 모니터링하고, 이를 기반으로 예방적 조치를 가능하게 함
  
- 상태 변화 발생 시 신속한 알림 및 대응 체계를 구축
  
- API 연동을 통해 위치 정보 및 건강 데이터를 수집함으로써 시니어들의 안전성과 삶의 질을 향상
  
- 업무 일지 작성 및 WebRTC 기술을 활용해 보호자와 요양 보호사 간 소통을 강화
  

# 2. 프로젝트 개요


**✨프로젝트 계획도**

![image](https://github.com/user-attachments/assets/d8a71246-5e68-4efc-9786-fa21b4214cbc)

***

**✨시나리오**

![image](https://github.com/user-attachments/assets/b7ecbac5-a54b-4980-8543-b8e7479ac162)

***

**✨업무 흐름도**

![image](https://github.com/user-attachments/assets/0fd11947-3ee2-41c5-b9e5-55c991374fa3)

***

**✨요구사항 분석**

**Service**

![image](https://github.com/user-attachments/assets/ee4bee08-3c4a-4d57-9841-674c1e162b69)

**Admin**

![image](https://github.com/user-attachments/assets/87155630-6e6e-41f7-9cf3-5af11bb03a7a)

***

**✨DB 설계(사진 저장 해 놓은 거 있으면 교체 해 주세요**

![image](https://github.com/user-attachments/assets/d93257a5-425c-4bc5-be03-65d86623ffa7)

***

**✨WBS**

![image](https://github.com/user-attachments/assets/ef2e2157-9311-4720-b00e-a47b727974ee)

***

**✨시스템 아키텍쳐**

![image](https://github.com/user-attachments/assets/b765f24d-c312-44ec-a14c-85bd16903b7e)

***

**✨개발 환경 및 수행 도구**
![image](https://github.com/user-attachments/assets/42fc9e38-2a19-438c-a48d-f61f7ff57ce2)


# 3. 프로젝트 역할분담

| 이름   | 역할                                                                                             |
|--------|--------------------------------------------------------------------------------------------------|
| 서효석 |                                                                 |
| 이동우 | 시니어 과거 건강 이력 차트 구현<br>시니어 실시간 이동 및 건강 이력 조회<br>시니어 및 회원 정보 수정<br>비밀번호 변경<br>상태 변경 기능 구현 |
| 이태빈 |                                                            |
| 조현열 |                                                                     |
| 진완규 | 사용자 아이디 및 비밀번호 찾기 기능 구현<br>사용자 회원가입 및 로그인 구현<br>WebSocket 기능을 통한 사용자와 관리자 소통 기능 구현<br>챗봇 API를 이용한 챗봇 기능 구현<br>보호사 마이페이지 기능 구현 |


# 4. 프로젝트 핵심 기능


## 메인 페이지


![image](https://github.com/user-attachments/assets/9fe0c319-f73f-4132-8e4a-d096e58c7b50)



## 고객 페이지

![image](https://github.com/user-attachments/assets/9adf6434-9b50-4989-8958-43a908f55fbd)



**- 로그인 완료 후 메인페이지의 모습입니다. 일정관리와 내 정보 외의 헤더 클릭 시, 시니어를 등록하는 페이지로 강제 리다이렉트 됩니다. 오른쪽 밑 말풍선 버튼을 클릭하면 관리자와 1대1 채팅 팝업이 나타납니다.**


## 보호사 신청 화면


![image](https://github.com/user-attachments/assets/27bf1026-9338-4911-b747-5cd47d44d471)


**- 시니어 등록 후 보호사 신청 페이지입니다. 보호사 신청 페이지에서는 시니어 위치 주변의 보호사를 거리별로 조회할 수 있습니다.**

## 계약 신청 화면

![image](https://github.com/user-attachments/assets/6a089d7f-606b-4a3c-9d0a-9369db0f4086)

**- 고객은 계약 시작 날짜와 종료 날짜를 설정한 후 계약 금액과 유의사항을 기입하여 계약 신청을 할 수 있습니다. 계약 신청은 보호사에게로 알림이 가며 보호사는 계약 관리 페이지에서 계약을 수락할 수 있습니다**

## 캘린더 화면

![image](https://github.com/user-attachments/assets/ba432778-5344-4bb4-a219-8cbf683a2363)

## 병원/약국 지도 화면

![image](https://github.com/user-attachments/assets/2f77e527-3b59-47e3-9b42-37cebe265273)

**- 시니어 거주지 인근 병원과 약국의 위치를 보여주는 화면입니다. 사용자가 시니어 주변 병원을 일일이 찾는 수고를 덜어줍니다**

## 시니어 상세 화면

![image](https://github.com/user-attachments/assets/7a54e45b-16cb-4b2f-8c5a-9750d1774f06)

**- 왼쪽 하단에 시니어의 정보와 보호사와 시니어가 얼마나 떨어져 있는지를 나타내는 지도가 배치되어 있습니다.**

**- 실시간 모니터링 탭에는 센서로부터 오는 시니어의 실시간 건강 정보를 나타냅니다. 하단에는 현재 시니어의 위치를 알 수 있는 지도가 포함되어 있습니다.**
  
**- 업무일지 탭에는 보호사는 해당 시니어에 대한 자신의 업무일지를 작성할 수 있으며 고객은 보호사가 작성한 업무일지를 조회할 수 있습니다.**

## WebRTC 고객-보호사 화상통화 화면

![image](https://github.com/user-attachments/assets/1b974872-044a-4ad5-9ed0-9cd78467f394)

**- 계약이 체결된 고객과 보호사의 화상통화 화면입니다**
  
**- 계약 정보의 PK를 자동으로 회의룸의 방번호로 설정하여 1대1 화상통화를 보장합니다**
  
**- 보호사가 시니어 집에 가정방문 했을 때 고객과 화상통화를 하거나, 고객과 보호사 간 상담 용도로 활용합니다**

## 보호사 업무일지 화면

![image](https://github.com/user-attachments/assets/2bc08781-29fc-433e-bd03-b51bdc33518e)

**- 보호사가 시니어의 집에 가정방문 한 뒤 작성하는 업무일지 페이지입니다**
  
**- 고객은 자신의 시니어에 대한 모든 업무일지를 조회할 수 있습니다**
  
**- SummerNote를 활용하여 글쓰기 편의성을 높입니다**

## 보호사가 관리하는 시니어 모니터링 화면

![image](https://github.com/user-attachments/assets/2e24da32-559d-4e94-adfb-9d91a2f2a9eb)

**- 보호사가 관리 중인 모든 시니어들의 실시간 위치를 표시합니다**

**- 시니어 마커를 클릭 후 상세페이지로 이동 가능합니다**

## 보호사 계약 관리 화면

![image](https://github.com/user-attachments/assets/a6bc2ce8-f3df-4aa3-8fa7-4d9668f45f29)

**- 보호사는 계약 내역을 전체, 대기중, 매칭완료 탭으로 분류하여 조회합니다**


---

## 관리자 화면

---
![image](https://github.com/user-attachments/assets/941de868-5f75-47c8-be46-c02ddd304322)

![image](https://github.com/user-attachments/assets/d47293f3-423c-4ce6-bfb4-1199fb6c116f)

**- 전체 고객 수, 채팅 활성도, 시니어 수, 보호사 수, 서버 사용량 추이 등의 통계적인 데이터를 확인할 수 있는 페이지입니다.**

# 트러블 슈팅

| **Name**   | **Issues**                                                                 | **Problem Solving**                                                                                 |
|------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| **서효석** | - Spring Boot 기본 설정으로 인해 파일 크기 제어가 안 되는 문제 발생 및 파일 저장 경로 지정 문제<br>- JSP 페이지에서 JavaScript와 연동 시 Ajax 통신 중 오류 발생 | - `application.yml`에서 파일 업로드 크기를 조정하고 파일 저장 경로를 설정<br>- JavaScript 코드 디버깅을 통해 통신 방식 수정 |
| **조현열** | - Jackson DataType 모듈이 LocalDateTime을 제대로 처리하지 못함<br>- API 호출 시 `CORS` 문제 발생 및 Spring Security 설정 충돌 | - Jackson Datatype JSR310 추가 및 `JavaTimeModule` 설정<br>- JSON 형식 결과값 Spring 설정 수정으로 문제 해결 |
| **이태빈** | - `keyframes slideUp` 애니메이션 작업 중 속도가 매끄럽지 않음<br>- `onmouseover` 이벤트가 중복 실행되는 문제                     | - CSS의 `transition` 사용으로 속도 개선<br>- 이벤트 처리 로직에서 `setTimeout`으로 딜레이를 추가해 중복 처리 문제 해결 |
| **이동우** | - 브라우저에서 전송 시 `body: JSON.stringify()`와 헤더에서 `content-type: application/json` 미설정으로 발생한 DB 에러<br>- DateTime 변환 시 UTC 시간이 저장되어 로컬 시간과 불일치 | - `fetch` 헤더에 `content-type: application/json` 추가하여 문제 해결<br>- 새로운 `DateFormatter` 설정으로 UTC 문제를 해결 |
| **진완규** | - WebSocket 설정 중 스프링 기본 설정에서 채팅 구독 문제가 발생<br>- `configureMessageBroker()` 호출 후 메시지 브로커 활성화가 안 됨 | - 새로 만든 스프링 구독 경로를 인덱스에서 별도로 처리<br>- `enableSimpleBroker()`로 메시지 브로커 활성화 |








