import Foundation
func parseTunningText() throws -> String {
    do {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = documentDirectory.appendingPathComponent("tunning.txt")
            
            let tunningText = try String(contentsOf: fileURL)
            print(tunningText)
            return tunningText
        }
    } catch {
        print("error:", error)
    }
    return ""
}

func checkForToken(possibleTokenArray array: [Character], lengthOfToken length: Int) -> Bool {
    var counts: [Character: Int] = [:]
    for item in array {
        counts[item] = (counts[item] ?? 0) + 1
    }
    if (counts.count == length) {
        return true
    }
    
    return false
}

func getToken(lengthOfToken length: Int) throws -> Int64 {
        let tunningText = Array(try parseTunningText())
        var letters: [Character] = []
        var i = 0
        while i < tunningText.count {
            for k in i...length + i + 1 {
                if (k >= tunningText.count) {
                    break
                }
                letters.append(tunningText[k])
                if (k == length + i - 1) {
                    if checkForToken(possibleTokenArray: letters, lengthOfToken: length) {
                        return Int64(k)
                    } else {
                        continue
                    }
                }
            }
            letters = []
            i += 1
            
        }
        return 0
}

print(try getToken(lengthOfToken: 4))
print(try getToken(lengthOfToken: 14))


