package edu.sm;

import edu.sm.util.HttpSendData;

public class Main {
	public static void main(String[] args) {
		String url = "http://127.0.0.1/iot/senior";
		int seniorId = 1; // 기본적으로 사용할 seniorId

		for (int i = 0; i < 100; i++) {
			// 랜덤 데이터 전송
			HttpSendData.send(url, seniorId);

			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
			}
		}
	}
}
