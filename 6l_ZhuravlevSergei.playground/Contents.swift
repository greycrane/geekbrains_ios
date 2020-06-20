import UIKit

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard elements.count > 0 else { return nil }
        return elements.removeFirst()
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
}



var evenNumber: (Int) -> Bool = { (element: Int) -> Bool in
    return element % 2 == 0
}

var greaterThanZero: (Int) -> Bool = { (element: Int) -> Bool in
    return element > 0
}

var intsArray = Queue<Int>()
intsArray.dequeue()
intsArray.enqueue(20)
intsArray.enqueue(13)
intsArray.enqueue(10)
intsArray.dequeue()
intsArray.enqueue(-4)
intsArray.enqueue(1217)
intsArray.enqueue(134)
print(intsArray)
print(intsArray.filter(predicate: evenNumber))

print(intsArray.filter(predicate: greaterThanZero))
