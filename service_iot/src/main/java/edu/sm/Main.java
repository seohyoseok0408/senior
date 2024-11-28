package edu.sm;

import edu.sm.util.HttpSendData;

public class Main {
	public static void main(String[] args) {
		String url = "http://127.0.0.1/iot/senior";

		for (int i = 0; i < 100; i++) {
			// 랜덤 데이터 전송
			HttpSendData.send(url);

			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
			}
		}
	}
}