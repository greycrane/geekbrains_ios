import UIKit

struct Stack<T> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        guard elements.count > 0 else { return nil }
        return elements.removeLast()
    }
    
    func filter(predicate: (Int) -> Bool) -> [Int] {
        var tmpArray = [Int]()
        for element in elements {
            if predicate(element as! Int) {
                tmpArray.append(element as! Int)
            }
        }
        return tmpArray
    }
    
    subscript(elements: Int ...) -> Bool? {
        if elements.count < 1 {
            return nil
        } else {
            return true
        }
    }
}



var evenNumber: (Int) -> Bool = { (element: Int) -> Bool in
    return element % 2 == 0
}

var greaterThanZero: (Int) -> Bool = { (element: Int) -> Bool in
    return element > 0
}

var intsArray = Stack<Int>()
intsArray.pop()
intsArray.push(20)
intsArray.push(13)
intsArray.push(10)
intsArray.pop()
intsArray.push(-4)
intsArray.push(1217)
intsArray.push(134)
print(intsArray)
print(intsArray.filter(predicate: evenNumber))

print(intsArray.filter(predicate: greaterThanZero))
