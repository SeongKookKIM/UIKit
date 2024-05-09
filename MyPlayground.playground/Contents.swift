import UIKit
import Foundation
import SwiftUI



// 오류 핸들링

enum WebsiteError: Error {
    case noInternetConnection
    case siteDown
    case wrongURL
}

func checkWebsite(siteUp: Bool) throws -> String {
    if siteUp == false {
        throw WebsiteError.siteDown
    }
    return "Site is up"
}

let siteStatus = false
do{
    print(try checkWebsite(siteUp: siteStatus))
} catch {
    print(error)
}












 
 /*
  
  
//프로토콜 + 확장

protocol CalorieCount {
    var calories: Int { get }
    func description() -> String
}

class Buger: CalorieCount {
    var calories: Int = 800
    
    func description() -> String {
        return "This burgers has \(calories) calories"
    }
}

struct Fries: CalorieCount {
    var calories: Int = 500
    
    func description() -> String {
        return "This Fries has \(calories) calories"
    }
}

enum Source {
    case chili
    case tomato
}

extension Source: CalorieCount {
    var calories: Int {
        switch self {
        case .chili :
            return 50
        case .tomato :
            return 100
        }
    }
    
    func description() -> String {
        return "This source has \(calories) calories"
    }
}

let buger = Buger()

let fries = Fries()

let source = Source.tomato

let foodArray: [CalorieCount] = [buger, fries, source]

var totalCalories = 0
for food in foodArray {
    totalCalories += food.calories
}

print(totalCalories)
  
*/







/*
// class 구조체
class Animal {
    var name: String
    var sound: String
    var numberOfLegs: Int
    var breathsOxygen: Bool = true
    
    init(name: String, sound: String, numberOfLegs: Int, breathsOxygen: Bool) {
        self.name = name
        self.sound = sound
        self.numberOfLegs = numberOfLegs
        self.breathsOxygen = breathsOxygen
    }
    
    func makeSound() {
        print(self.sound)
    }
    
    func desription() -> String {
        return "name: \(name) \nsound: \(self.sound) \nnumberOfLegs: \(self.numberOfLegs) \nbreathsOxygen: \(self.breathsOxygen)"
    }
}

class Mamal:Animal {
    let hasFurOrHair: Bool
    
    // 부모 클래스의 이니셜라이저를 호출하도록 수정
    init(name: String, sound: String, numberOfLegs: Int, breathsOxygen: Bool, hasFurOrHair: Bool) {
        self.hasFurOrHair = hasFurOrHair // 여기서 초기화
        super.init(name: name, sound: sound, numberOfLegs: numberOfLegs, breathsOxygen: breathsOxygen)
    }
    
    override func desription() -> String {
        return super.desription() + "\nhasFurOrHair: \(self.hasFurOrHair)"
    }
}

let cat: Mamal = Mamal(name: "Cat", sound: "Mew", numberOfLegs: 4, breathsOxygen: true, hasFurOrHair: false)
print(cat.desription())


print("=================================")

struct Reptile {
    var name: String
    var sound: String
    var numberOfLegs: Int
    var breathsOxygen: Bool
    let hasFurOrHair: Bool = false
    
    func makeSound() {
        print(sound)
    }
    
    func description() -> String {
        return "Structure name: \(name) \nStructure sound: \(self.sound) \nStructure numberOfLegs: \(self.numberOfLegs) \nStructure breathsOxygen: \(self.breathsOxygen)"
    }
}

var snake = Reptile(name: "Snake", sound: "Hisss", numberOfLegs: 0, breathsOxygen: true)
print(snake.description())
snake.makeSound()

print("=================================")

enum TrafficLightColor: String {
    case red
    case yellow
    case green
    
    func description() -> String {
        switch self {
        case .red:
            return "red"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        }
    }
}

var trafficLightColor = TrafficLightColor.red
print(trafficLightColor.description())
print(trafficLightColor.rawValue)
 */
    
    

/*
// 함수와 클로저

func serviceCharge() {
    let mealCost = 50
    let serviceCharge = mealCost / 10
    print("Service Charge is \(serviceCharge)")
}

serviceCharge()

func serviceCharge(mealCost: Int) -> Int {
    return mealCost / 10
}

let serviceChargeAmount = serviceCharge(mealCost: 50)
print(serviceChargeAmount)

// custom argument label
func serviceCharge(forMealPrice mealCost: Int) -> Int {
    return mealCost / 15
}

let serviceChargeAmount2 = serviceCharge(forMealPrice: 50)
print(serviceChargeAmount2)

// 중첩함수

func calculateMonthlyPayments(carPrice: Double, downPayment: Double, interestRate: Double, paymentTerm: Double) -> Double {
    func loanAmount() -> Double {
        return carPrice - downPayment
    }
    
    func totalInterest() -> Double {
        return interestRate * paymentTerm
    }
    
    func numberOfMonth() -> Double {
        return paymentTerm * 12
    }
    
    return((loanAmount() + (loanAmount() * totalInterest() / 100)) / numberOfMonth())
}

calculateMonthlyPayments(carPrice: 50000, downPayment: 5000, interestRate: 3.5, paymentTerm: 7)


func makePi() -> (() -> Double) {
    func generatePi() -> Double {
        return 22.0 / 7.0
    }
    
    return generatePi
}

let pi = makePi()
print(pi())


func isThereAMathch(listOfNumbers: [Int], condition: (Int) -> Bool) -> Bool {
    for item in listOfNumbers {
        if condition(item) {
            return true
        }
    }
    return false
}

func oddNumber(number: Int) -> Bool {
    return (number % 2) > 0
}

let numbersList = [2,4,6,7]

isThereAMathch(listOfNumbers: numbersList, condition: oddNumber)


func buySomething(itemValueEntered itemValueField: String, cardBalance: Int) -> Int {
    guard let itemValue = Int(itemValueField) else {
        print("error in item value")
        return cardBalance
    }
    let remainingBalance = cardBalance - itemValue
    return remainingBalance
}

print(buySomething(itemValueEntered: "10", cardBalance: 50))
print(buySomething(itemValueEntered: "blue", cardBalance: 50))

var numbersArray = [2,4,5,7]
let myClosure = { (number: Int) -> Int in
    let result = number * number
    return result
}
let mappedNumbers = numbersArray.map(myClosure)

var testNumbers = [2,4,6,7]
let mappedTestNumbers = testNumbers.map({ (number: Int) -> Int in
    let result = number * number
    return result
})
print(mappedTestNumbers)

let mappedTestNumbers2 = testNumbers.map({ number in
        number * number
})
print(mappedTestNumbers2)

let mappedTestNumbers3 = testNumbers.map { $0 * $0}
print(mappedTestNumbers3)
 
*/



//
//var greeting = "Hello, playground"
//
//
//let isRestautantOpen = true
//
//if isRestautantOpen {
//    print("레스토랑 오픈")
//} else {
//    print("레스토랑 닫음.")
//}
//
//let isRestaurantFound = false
//
//if !isRestaurantFound {
//    print("레스토랑 못 찾음")
//}
//
//let drinkingAgeLimit = 21
//let cutomerAge = 23
//
//if cutomerAge < drinkingAgeLimit {
//    print("Under age limit")
//} else {
//    print("Over age limit")
//}
//
//let trafficLightColor = Color.yellow
//
//
//switch trafficLightColor {
//    case .red:
//        print("Strop")
//    case .yellow:
//        print("Caution")
//    case .green:
//        print("Go")
//    default:
//        print("Invalid color")
//}
//
//var spouseName: String?
//
//print(spouseName ?? "No Name")
//
//if let spouseTempVar = spouseName {
//    let greeting = spouseTempVar
//    print("\(greeting)")
//} else {
//    print("No Greeting@@@@@")
//}
//
//let myRange = 10...20
//let myRange2 = 10..<20
//
//for number in myRange {
//    print(number)
//}
//
//for number in myRange2 {
//    print(number)
//}
//
//for number in (0...5).reversed() {
//    print(number)
//}
//
//var y = 0
//while y < 50 {
//    y += 5
//    print("y is \(y)")
//}
//
//var x = 0
//// 무조건 한 번 실행
//repeat {
//    x += 5
//    print("x is \(x)")
//} while x < 50
//
//
//print("============================")
//
//var shoppingList = ["Egg", "Milk"]
//
//print(shoppingList.count)
//
//shoppingList.append("Cooking Oil")
//shoppingList = shoppingList + ["chicken"]
//print(shoppingList)
//
//shoppingList.insert("Water", at: 2)
//
//shoppingList.remove(at: 1)
//
//let removeElement = shoppingList.removeLast()
//print(shoppingList)
//print("Remove: \(removeElement)")
//
//print("============================")
//
//var contactList = ["Shah": "+6012345456789", "Aamor": "+02234546789"]
//print(contactList.count)
//print(contactList.isEmpty)
//
//contactList["Jane"] = "+0229876543"
//print(contactList)
//
//var oldDictValue = contactList.removeValue(forKey: "Aamor")
//print(oldDictValue ?? "NoValue")
//print(contactList)
//
//for (name, contactNumber) in contactList {
//    print("\(name): \(contactNumber)")
//}
//
//var movieGeneres: Set = ["Horror", "Action", "Romentic"]
//
//print(movieGeneres.count)
//print(movieGeneres.isEmpty)
//
//movieGeneres.insert("War")
//
//print(movieGeneres)
//
//movieGeneres.contains("War")
//
//var oldSetValue = movieGeneres.remove("Action")
//print(oldSetValue ?? "No Value")
//
//for genre in movieGeneres {
//    print(genre)
//}
//
//
//let movieGenres2: Set = ["SF", "War", "Fantasy"]
//
//// 합집합
//movieGeneres.union(movieGenres2)
//// 교집합
//movieGeneres.intersection(movieGenres2)
//// 차집합 - 차집합은 하나의 집합에서 다른 집합의 모든 요소를 제거한 결과입니다.
//movieGeneres.subtracting(movieGenres2)
//// 대칭 차집합 - 대칭 차집합은 각 집합에만 속하는 요소들의 모음입니다. 즉, 한 집합에만 속하는 요소들뿐만 아니라 두 집합에 공통으로 속하는 요소들은 포함하지 않습니다.
//movieGeneres.symmetricDifference(movieGenres2)
//
//movieGeneres == movieGenres2
//// inSubset - 집합 A가 집합 B의 부분집합(subset)이라는 것은 집합 A의 모든 요소가 집합 B에도 포함되는 것을 의미합니다.
//// inSuperset - 집합 A가 집합 B의 상위집합(superset)이라는 것은 집합 B의 모든 요소가 집합 A에도 포함되는 것을 의미합니다. 즉, B의 모든 요소가 A에도 포함되면, A는 B의 상위집합입니다.
//
//
