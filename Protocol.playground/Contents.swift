import UIKit

// Hashable 프로토콜을 준수하는 구조체
struct Point: Hashable {
    let x: Int
    let y: Int
}

// Hashable 프로토콜을 준수하는 연관 값이 있는 열거형
enum Result {
    case success(Int)
    case failure(String)
}

extension Result: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .success(value):
            hasher.combine("success")
            hasher.combine(value)
        case let .failure(error):
            hasher.combine("failure")
            hasher.combine(error)
        }
    }
}

// Hashable 프로토콜을 준수하는 구조체
let point = Point(x: 10, y: 20)

// Hashable 프로토콜을 준수하는 연관 값이 있는 열거형
let successResult = Result.success(42)
let failureResult = Result.failure("Error")

// 값 출력
print("Point:", point)
print("Success Result:", successResult)
print("Failure Result:", failureResult)
