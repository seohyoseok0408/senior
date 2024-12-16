package edu.sm;

import edu.sm.util.HttpSendData;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
	public static void main(String[] args) {
		String url = "http://127.0.0.1/iot/senior";
		String admin_url = "http://127.0.0.1:81/iot/senior";

		int seniorId = 2; // 기본적으로 사용할 seniorId
		ExecutorService executor = Executors.newFixedThreadPool(2); // 스레드 풀 생성

		for (int i = 0; i < 100; i++) {
			// 비동기로 두 URL에 요청 전송
			executor.execute(() -> sendRequest(url, seniorId));
			executor.execute(() -> sendRequest(admin_url, seniorId));

			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
			}
		}

		executor.shutdown(); // 스레드 풀 종료
	}

	private static void sendRequest(String url, int seniorId) {
		try {
			HttpSendData.send(url, seniorId);
			System.out.println("성공적으로 전송됨: " + url);
		} catch (Exception e) {
			System.err.println("전송 실패: " + url + " - " + e.getMessage());
		}
	}
}

