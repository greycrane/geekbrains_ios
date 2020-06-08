import Foundation

enum Manufacturer: String {
    case kia = "Kia"
    case ford = "Ford"
    case audi = "Audi"
    case volvo = "Volvo"
    case man = "MAN"
    case scania = "Scania"
}

enum EngineState {
    case on, off
}

enum WindowsState {
    case opened, closed
}

enum Errors: String {
    case baggageTooBig = "Ошибка! Багаж слишном большой."
    case baggageVolumeNotExists = "Ошибка! Нет столько багажа."
    case baggageLessThanZero = "Ошибка! Багаж не может быть меньше нуля."
    case cargoTooBig = "Ошибка! Груз слишном большой."
    case cargoVolumeNotExists = "Ошибка! Нет столько груза."
    case cargoLessThanZero = "Ошибка! Груз не может быть меньше нуля."
}

enum CarAction {
    case windowsOpen
    case windowsClose
    case engineStart
    case engineStop
    case addBaggage(volume: Int?)
    case removeBaggage(volume: Int?)
}

enum TruckAction {
    case windowsOpen
    case windowsClose
    case engineStart
    case engineStop
    case addCargo(volume: Int?)
    case removeCargo(volume: Int?)
}

struct Car {
    let manufacturer: Manufacturer
    let year: Int
    let trunkVolume: Int
    var engineState: EngineState = .off {
        didSet {
            if engineState == .on {
                print("Двигатель включен.")
            } else {
                print("Двигатель выключен.")
            }
            
        }
    }
    var windowsState: WindowsState = .closed {
        didSet {
            if windowsState == .opened {
                print("Окна открыты.")
            } else {
                print("Окна закрыты.")
            }
            
        }
    }
    var trunkUsedSpace: Int = 0
    
    mutating func action (act: CarAction) {
        switch act {
        case .engineStart:
            self.engineState = .on
        case .engineStop:
            self.engineState = .off
        case .windowsOpen:
            self.windowsState = .opened
        case .windowsClose:
            self.windowsState = .closed
        case let .addBaggage(volume):
            if let vol = volume, vol > 0 && vol <= self.freeSpace() {
                self.trunkUsedSpace += volume!
                print("Загружено \(volume!) л багажа.")
            } else if volume! > self.freeSpace() {
                print(Errors.baggageTooBig.rawValue)
            } else {
                print(Errors.baggageLessThanZero.rawValue)
            }
        case let .removeBaggage(volume):
            if let vol = volume, vol > 0 && vol <= self.trunkUsedSpace {
                self.trunkUsedSpace -= volume!
                print("Выгружено \(volume!) л багажа.")
            } else if volume! > self.trunkUsedSpace {
                print(Errors.baggageTooBig.rawValue)
            } else {
                print(Errors.baggageLessThanZero.rawValue)
            }
        }
    }
    
    func engineIsOn () -> Bool {
        return engineState == .on
    }
    
    func windowsOpened () -> Bool {
        return windowsState == .opened
    }
    func freeSpace() -> Int {
        return trunkVolume - trunkUsedSpace
    }
}

struct Truck {
    let manufacturer: Manufacturer
    let year: Int
    let cargoVolume: Int
    var engineState: EngineState = .off {
        didSet {
            if engineState == .on {
                print("Двигатель теперь включен.")
            } else {
                print("Двигатель теперь выключен.")
            }
            
        }
    }
    var windowsState: WindowsState = .closed {
        didSet {
            if windowsState == .opened {
                print("Окна теперь открыты.")
            } else {
                print("Окна теперь закрыты.")
            }
            
        }
    }
    var cargoUsedSpace: Int = 0
    
    mutating func action (act: TruckAction) {
        switch act {
        case .engineStart:
            self.engineState = .on
        case .engineStop:
            self.engineState = .off
        case .windowsOpen:
            self.windowsState = .opened
        case .windowsClose:
            self.windowsState = .closed
        case let .addCargo(volume):
            if let vol = volume, vol > 0 && vol <= self.freeSpace() {
                self.cargoUsedSpace += volume!
                print("Загружено \(volume!) л груза.")
            } else if volume! > self.freeSpace() {
                print(Errors.cargoTooBig.rawValue)
            } else {
                print(Errors.cargoLessThanZero.rawValue)
            }
        case let .removeCargo(volume):
            if let vol = volume, vol > 0 && vol <= self.cargoUsedSpace {
                self.cargoUsedSpace -= volume!
                print("Выгружено \(volume!) л груза.")
            } else if volume! > self.cargoUsedSpace {
                print(Errors.cargoVolumeNotExists.rawValue)
            } else {
                print(Errors.cargoLessThanZero.rawValue)
            }
        }
    }
    
    func engineIsOn () -> Bool {
        return engineState == .on
    }
    
    func windowsOpened () -> Bool {
        return windowsState == .opened
    }
    func freeSpace() -> Int {
        return cargoVolume - cargoUsedSpace
    }
}

var kiaSoul = Car(manufacturer: .kia, year: 2016, trunkVolume: 500)
var manTruck = Truck(manufacturer: .man, year: 2010, cargoVolume: 2000)


print(kiaSoul.freeSpace())
kiaSoul.action(act: .addBaggage(volume: 300))
print(kiaSoul.freeSpace())
kiaSoul.action(act: .removeBaggage(volume: 200))
print(kiaSoul.freeSpace())
kiaSoul.action(act: .windowsOpen)
kiaSoul.action(act: .engineStart)


print(manTruck.freeSpace())
manTruck.action(act: .addCargo(volume: 1500))
print(manTruck.freeSpace())
manTruck.action(act: .removeCargo(volume: 12400))
print(manTruck.freeSpace())
manTruck.action(act: .windowsOpen)
print(manTruck.windowsOpened())
manTruck.action(act: .windowsClose)
manTruck.action(act: .engineStart)
print(manTruck.engineIsOn())
manTruck.action(act: .engineStop)
print(manTruck.windowsOpened())
print(manTruck.engineIsOn())
