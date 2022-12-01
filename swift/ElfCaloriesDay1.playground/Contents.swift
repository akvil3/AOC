import Foundation

/// Main class thats representing an Elf.
/// Each elf carries an specific amount of calories. The bags are represented as an array.
class Elf {
    var calories: [Int]
    var totalCalories: Int
    
    init(elfCalories calories: [Int]) {
        self.calories = calories
        self.totalCalories = 0
        self.totalCalories = getTotalCalories()
    }
    
    func getTotalCalories() -> Int {
        let total = self.calories.reduce(0) {(result, next) -> Int in
            return result + next
        }
        return total
    }
}

func parseElf() throws -> [Elf]  {
    do {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = documentDirectory.appendingPathComponent("calories.txt")
            
            let savedText = try String(contentsOf: fileURL)
            let splitted = savedText.components(separatedBy: "\n\n")
            
            let elfs = splitted.map({ (sequence) -> Elf in
                let caloriesList = sequence.components(separatedBy: "\n").map({ (calorieCount) -> Int in
                    Int(calorieCount) ?? 0
                })
                return Elf(elfCalories: caloriesList)
            })
            return elfs
        }
    } catch {
        print("error:", error)
    }
    return []
}

// Part One
func getMaxElf(allElfs elfs: [Elf]) throws -> (Int?, Int) {
    let totalCalories: [Int]? =  try elfs.map({(elf) throws -> Int in
        return elf.totalCalories
    })
    let max_index: Int = Int(totalCalories?.firstIndex(where: { $0 == totalCalories?.max()}) ?? 0)
    return (totalCalories?.max(), max_index)
}

// Part Two
func getTopThree(allElfs elfs: [Elf], indexFromMaxElf i: Int, caloriesFromMaxElf c: Int ) throws -> Int {
    var sum = c;
    var newElfs = elfs;
    newElfs.remove(at: i);
    
    // Get the elf with the max calorie amount and remove from the array
    for _ in Range(uncheckedBounds: (0, 2)) {
        let (totalCalories, index) = try getMaxElf(allElfs: newElfs);
        print(totalCalories ?? 0)
        sum += totalCalories ?? 0
        newElfs.remove(at: index)
    }
    return sum
}

let elfs = try? parseElf()

let (firstCalories, index) = try getMaxElf(allElfs: elfs ?? [])
print(try getTopThree(allElfs: elfs ?? [], indexFromMaxElf: index, caloriesFromMaxElf: firstCalories ?? 0))
