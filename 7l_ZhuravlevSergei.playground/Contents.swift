import UIKit

struct Item {
    var numberOfItems: Int
    let product: Product
}

struct Product {
    let name: String
}

enum FridgeErrors: Error {
    case noSuchProduct
    case outOfProduct
    case zeroOrLess
}

enum CarErrors: Error {
    case noMoreWheels
    case zeroOrLess
}

class Fridge {
    var products = [
        "Eggs": Item(numberOfItems: 12, product: Product(name: "Eggs")),
        "Milk": Item(numberOfItems: 3, product: Product(name: "Milk")),
        "Steaks": Item(numberOfItems: 2, product: Product(name: "Steaks")),
        "Carrot": Item(numberOfItems: 8, product: Product(name: "Carrot")),
        "Juice": Item(numberOfItems: 1, product: Product(name: "Juice")),
        "Cakes": Item(numberOfItems: 2, product: Product(name: "Cakes"))
    ]

    func getProduct(itemNamed name: String, numberOfItems quantity: Int) throws -> Product? {
        guard let item = products[name] else {
            throw FridgeErrors.noSuchProduct
        }
        guard item.numberOfItems >= quantity else {
            throw FridgeErrors.outOfProduct
        }
        guard quantity > 0 else {
            throw FridgeErrors.zeroOrLess
        }
        var newItem = item
        newItem.numberOfItems -= quantity
        products[name] = newItem
        print("Returning \(name)")
        return newItem.product
    }
}

let fridge = Fridge()

do {
    try fridge.getProduct(itemNamed: "Cakes", numberOfItems: 2)
} catch FridgeErrors.noSuchProduct {
    print("Продукт закончился.")
} catch FridgeErrors.outOfProduct {
    print("Продукт закончился.")
} catch FridgeErrors.zeroOrLess {
    print("Введите количество продукта больше нуля.")
} catch let error {
    print(error.localizedDescription)
}

do {
    try fridge.getProduct(itemNamed: "Lemon", numberOfItems: 1)
} catch FridgeErrors.noSuchProduct {
    print("Нет такого продукта.")
} catch FridgeErrors.outOfProduct {
    print("Продукт закончился.")
} catch FridgeErrors.zeroOrLess {
    print("Введите количество продукта больше нуля.")
} catch let error {
    print(error.localizedDescription)
}

do {
    try fridge.getProduct(itemNamed: "Eggs", numberOfItems: -1)
} catch FridgeErrors.noSuchProduct {
    print("Нет такого продукта.")
} catch FridgeErrors.outOfProduct {
    print("Продукт закончился.")
} catch FridgeErrors.zeroOrLess {
    print("Введите количество продукта больше нуля.")
} catch let error {
    print(error.localizedDescription)
}

class Car {
    var wheels: Int = 4

    func takeWheelOff(wheels: Int) -> (Int?, Error?) {
        guard wheels <= self.wheels else {
            return (nil, CarErrors.noMoreWheels)
        }
        guard wheels > 0 else {
            return (nil, CarErrors.zeroOrLess)
        }
        self.wheels -= wheels
        return (self.wheels, nil)
    }
}

let mazda = Car()
let takeOffResult = mazda.takeWheelOff(wheels: 5)
if let _ = takeOffResult.0 {
    print("Количество оставшихся колес: \(mazda.wheels)")
} else if let error = takeOffResult.1 {
    print("Произошла ошибка: \(error)")
}
