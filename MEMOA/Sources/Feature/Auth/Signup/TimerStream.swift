// TimerStream.swift
import Foundation

// 타이머 스트림 생성 함수
func timerStream() -> AsyncStream<Int> {
    return AsyncStream<Int> { continuation in
        /// 시간 제한 5분
        var validTimeSeconds = 5 * 60 - 1
        
        // 타이머를 설정
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            guard validTimeSeconds >= 0 else {
                timer.invalidate() // 타이머 중지
                continuation.finish() // 스트림 종료
                return
            }
            continuation.yield(validTimeSeconds) // 현재 시간을 발행
            validTimeSeconds -= 1 // 시간을 1초 감소
        }
        
        // 스트림이 종료될 때 타이머를 해제
        continuation.onTermination = { _ in
            timer.invalidate() // 타이머 중지
        }
    }
}
