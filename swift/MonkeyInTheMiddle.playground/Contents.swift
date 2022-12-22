import Foundation

enum Operation {
    case addition, subtraction, multiplication, division
}

class Monkey {
    var id: Int
    var items: [Int]
    var items2: [Int64]
    var operation: (Operation, Int)
    var testValue: Int
    var responsibleMonkeys: [Int]
    var count: Int
    var count2: Int64
    
    init(monkeyDescription desc: [String]) {
        let desc_parsed = desc.map({(text) -> [String] in
            text.components(separatedBy: ":")})
        let id = Int(desc_parsed[0][0].components(separatedBy: " ")[1]) ?? 0
        let values = parseStartingItems(startingItemsText: desc_parsed[1][1]);
        let operation = defineOperation(operationText: desc_parsed[2][1])
        let testValue = defineTest(testDescription: desc_parsed[3][1])
        let responsibleMonkeys = getTestCases(trueResultDescription: desc_parsed[4][1], falseResultDescription: desc_parsed[5][1])
        let values2 = parseStartingItems2(startingItemsText: desc_parsed[1][1])
        self.id = id
        self.items = values
        self.items2 = values2
        self.operation = operation
        self.testValue = testValue
        self.responsibleMonkeys = responsibleMonkeys
        self.count = 0
        self.count2 = 0
    }
    
    func doOperation(itemToUse item: Int) -> Int {
        let operation = self.operation
        var val = self.operation.1
        if self.operation.1 == -1 {
            val = item
        }
        switch self.operation.0 {
            case .addition:
                return item + val
            case .multiplication:
                return item * val
            case .subtraction:
                return item - val
            case .division:
                return item / val
        }
    }
    
    func doOperation2(itemToUse item: Int64) -> Int64 {
        let operation = self.operation
        var val = Int64(self.operation.1)
        if self.operation.1 == -1 {
            val = item
        }
        switch self.operation.0 {
            case .addition:
                return item + val
            case .multiplication:
                return item * val
            case .subtraction:
                return item - val
            case .division:
                return item / val
        }
    }
    
    func doTestCase(resultToTest input: Int) -> Bool{
        return input % self.testValue == 0
    }
    
    func doTestCase2(resultToTest input: Int64) -> Bool {
        return input % Int64(self.testValue) == 0
    }
}

func parseStartingItems(startingItemsText text: String) -> [Int] {
    let values = text.components(separatedBy: ",").map({ (value) -> Int in
        Int(String(value).dropFirst(1)) ?? 0})
    return values
}

func parseStartingItems2(startingItemsText text: String) -> [Int64] {
    let values = text.components(separatedBy: ",").map({ (value) -> Int64 in
        Int64(String(value).dropFirst(1)) ?? 0})
    return values
}

func defineOperation(operationText text: String) -> (Operation, Int) {
    let splitted = text.components(separatedBy: " ")
    var operation: Operation = Operation.division
    switch (splitted[4]) {
        case "+":
            operation = Operation.addition
            break
        case "-":
            operation = Operation.subtraction
            break
        case "*":
            operation = Operation.multiplication
            break
        case "/":
            operation = Operation.division
            break
    default:
            operation = Operation.addition
            break
    }
    if splitted[5] == "old" {
        return (operation, -1)
    }
    let value = Int(splitted[5]) ?? 0
    return (operation, value)
}

func defineTest(testDescription text: String) -> Int {
    let value = Int(text.components(separatedBy: " ")[3]) ?? 0
    return value

}

func getTestCases(trueResultDescription true_text: String, falseResultDescription false_text: String) -> [Int] {
    let true_conditions = Int(true_text.components(separatedBy: " ")[4]) ?? 0
    let false_conditions = Int(false_text.components(separatedBy: " ")[4]) ?? 0
    let result = [true_conditions, false_conditions]
    return result
}

func parseMonkeys() throws -> [Monkey]  {
    do {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = documentDirectory.appendingPathComponent("monkeys.txt")
            
            let savedText = try String(contentsOf: fileURL)
            let splitted = savedText.components(separatedBy: "\n\n")
            let monkeys = splitted.map({ (sequence) -> Monkey in
                let monkey_text = sequence.components(separatedBy: "\n")
                let monkey = Monkey.init(monkeyDescription: monkey_text)
                return monkey
            })
            return monkeys
        }
    } catch {
        print("error:", error)
    }
    return []
}

func product_divisor(monkeysList monkeys: [Monkey]) -> Int64 {
    var product = 1
    for monkey in monkeys {
        product *= monkey.testValue
    }
    return Int64(product)

}

func monkeyBusiness(monkeyInput monkeys: [Monkey], roundsCount c: Int) -> Int {
    var i = 0
    while i < c {
        for monkey in monkeys {
            print(monkey.items)
            for item in monkey.items {
                let boredom = monkey.doOperation(itemToUse: item)
                let divided = boredom / 3
                let testCase = monkey.doTestCase(resultToTest: divided)
                var monkeyId = 0
                if testCase {
                    monkeyId = monkey.responsibleMonkeys[0]
                } else {
                    monkeyId = monkey.responsibleMonkeys[1]
                }
                for monkey_to_find in monkeys {
                    if monkey_to_find.id == monkeyId {
                        monkey_to_find.items.append(divided)
                        break
                    }
                }
                monkey.items.removeAll { val in
                    return val == item
                }
                monkey.count += 1
            }
            print(monkey.items)
        }
        i += 1
    }
    
    var counts = monkeys.map({(monkey) -> Int in
        return monkey.count
    })
    counts.sort(by: >)
    return (counts[0] * counts[1])
}


func monkeyBussinessPart2(monkeyInput monkeys: Array<Monkey>, roundsCount c: Int) async -> Int {
    var i = 0
    let divisor = product_divisor(monkeysList: monkeys)
    var monkeysCount = Array(repeating: 0, count: monkeys.count)
    while i < c {
        var monkey_index = 0
        for monkey in monkeys {
            monkeysCount[monkey_index] += monkey.items2.count
            for item in monkey.items2 {
                let worry = monkey.doOperation2(itemToUse: item) % divisor
                var monkeyId = 0
                let testCase = monkey.doTestCase2(resultToTest: worry)
                if testCase {
                    monkeyId = monkey.responsibleMonkeys[0]
                } else {
                    monkeyId = monkey.responsibleMonkeys[1]
                }
                
                monkeys[monkeyId].items2.append(worry)
               
                monkey.items2.removeAll()
            }
            monkey_index += 1
        }
        i += 1
    }
    
    let sorted = monkeysCount.sorted(by: >)
    return (sorted[0] * sorted[1])
}

let monkeys = try parseMonkeys()
//let bussiness = monkeyBusiness(monkeyInput: monkeys, roundsCount: 20)
let bussiness2 = await monkeyBussinessPart2(monkeyInput: monkeys, roundsCount: 10000)
print(bussiness2)
