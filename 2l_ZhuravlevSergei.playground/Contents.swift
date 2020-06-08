import Foundation

func isEven(num: Int) -> Bool {
    if num % 2 == 0 {
        return true
    } else {
        return false
    }
}

print("Задание 1:\n\(isEven(num: 76))\n")

func isDividedByThree (num: Int) -> Bool {
    if num % 3 == 0 {
        return true
    } else {
        return false
    }
}

print("Задание 2:\n\(isDividedByThree(num: 8))\n")

func arrayOfHundredNumbers ( num: Int) -> [Int] {
    var arr = [Int]()
    var element = num
    
    while arr.count < 100 {
        arr.append(element)
        element += 1
    }
    
    return arr
}

var arrayIncreasing = arrayOfHundredNumbers(num: 32)

print("Задание 3:\n\(arrayIncreasing)\n")

func removeEvensAndDividedByThree (array: inout [Int]) -> [Int] {
    for (_, value) in array.enumerated() {
        if (isEven(num: value) || isDividedByThree(num: value)) {
            array.remove(at: array.firstIndex(of: value)!)
        }
    }
    return array
}

print("Задание 4:\n\(removeEvensAndDividedByThree(array: &arrayIncreasing))\n")

func createFibonacciArray (num1: Double, num2: Double) -> [Double] {
    var array: [Double] = [num1, num2]
    while array.count < 100 {
        array.append(array[array.count-1] + array[array.count-2])
    }
    return array
}

print("Задание 5:\n\(createFibonacciArray(num1: 1, num2: 2))\n")

func primeNumbers(arraySize: Int) -> [Int] {
    var array: [Int] = [2]
    var divider: Int = array.last! + 1
    var isPrime: Bool = true
    
    while array.count < arraySize {
        for index in stride(from: array.count - 1, through: 0, by: -1) {
            if divider % array[index] == 0 {
                isPrime = false
            }
    }
        
    if isPrime == true {
        array.append(divider)
    }
        
        divider += 1
        isPrime = true
    }
    return array
}

print("Задание 6:\n\(primeNumbers(arraySize: 100))\n")
