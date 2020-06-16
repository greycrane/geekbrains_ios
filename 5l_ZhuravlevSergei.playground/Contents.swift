import Foundation

enum Manufacturer: String {
    case kia = "Kia"
    case ford = "Ford"
    case audi = "Audi"
    case ferrari = "Ferrari"
    case porsche = "Porsche"
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

enum SpoilerState {
    case up, down
}

enum SunroofState {
    case opened, closed
}

enum Color {
    case black
    case white
    case silver
    case red
    case blue
}

enum Transmission: String {
    case automatic = "автоматическая", manual = "ручная", robotic = "роботизированная"
}

enum Errors: String {
    case baggageTooBig = "Ошибка! Багаж слишном большой."
    case baggageVolumeNotExists = "Ошибка! Нет столько багажа."
    case baggageLessThanZero = "Ошибка! Багаж не может быть меньше нуля."
    case cargoTooBig = "Ошибка! Груз слишном большой."
    case cargoVolumeNotExists = "Ошибка! Нет столько груза."
    case cargoLessThanZero = "Ошибка! Груз не может быть меньше нуля."
    case actionNotAvailable = "Ошибка! Действие недоступно."
}

enum CarAction {
    case windowsOpen, windowsClose, engineStart, engineStop, spoilerUp, spoilerDown, sunroofOpen, sunroofClose
    case addCargo(volume: Int?)
    case removeCargo(volume: Int?)
}

protocol Car {
    var manufacturer: Manufacturer { get set }
    var year: Int { get set }
    var transmission: Transmission { get set }
    var color: Color { get set }
    var engineState: EngineState { get set }
    var windowsState: WindowsState { get set }

    func doAction (act: CarAction)
}

extension Car {
    func engineIsOn () -> Bool {
        return engineState == .on
    }

    func windowsOpened () -> Bool {
        return windowsState == .opened
    }
}

class SportCar: Car {
    var manufacturer: Manufacturer
    var year: Int
    var transmission: Transmission
    var color: Color
    var engineState: EngineState = .off
    var windowsState: WindowsState = .closed
    
    var spoilerState: SpoilerState = .down {
        didSet {
            if spoilerState == .down {
                print("Спойлер опущен.")
            } else {
                print("Спойлер поднят.")
            }
        }
    }
    
    var sunroofState: SunroofState = .closed {
        didSet {
            if sunroofState == .closed {
                print("Люк закрыт.")
            } else {
                print("Люк открыт.")
            }
        }
    }
    
    let hasSpoiler: Bool
    let hasSunroof: Bool
    
    required init(manufacturer: Manufacturer, year: Int, transmission: Transmission, color: Color, hasSpoiler: Bool, hasSunroof: Bool) {
        self.manufacturer = manufacturer
        self.year = year
        self.transmission = transmission
        self.color = color
        self.hasSpoiler = hasSpoiler
        self.hasSunroof = hasSunroof
    }
    
    func doAction(act: CarAction) {
        switch act {
        case .engineStart:
            self.engineState = .on
        case .engineStop:
            self.engineState = .off
        case .windowsOpen:
            self.windowsState = .opened
        case .windowsClose:
            self.windowsState = .closed
        case .spoilerUp:
            if self.hasSpoiler == true {
                self.spoilerState = .up
            }
            else {
                print(Errors.actionNotAvailable.rawValue)
            }
        case .spoilerDown:
            if self.hasSpoiler == true {
                self.spoilerState = .down
            } else {
                print(Errors.actionNotAvailable.rawValue)
            }
        case .sunroofOpen:
            if self.hasSunroof == true {
                self.sunroofState = .opened
            } else {
                print(Errors.actionNotAvailable.rawValue)
            }
        default:
            print(Errors.actionNotAvailable.rawValue)
        }
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Спортивный автомобиль марки \(manufacturer.rawValue) \(year) года выпуска.\nКоробка передач: \(transmission.rawValue)\nДвигатель: \(engineState == .on ? "включен" : "выключен")\nОкна: \(windowsState == .opened ? "открыты" : "закрыты")\nСпойлер: \(hasSpoiler ? "\(spoilerState == .up ? "поднят" : "опущен")" : "отсутствует")\nЛюк: \(hasSunroof ? "\(sunroofState == .opened ? "открыт" : "закрыт")" : "отсутствует")"
    }
}
    
var audiTT = SportCar(manufacturer: .audi, year: 2010, transmission: .automatic, color: .black, hasSpoiler: false, hasSunroof: true)
audiTT.doAction(act: .spoilerUp)
audiTT.doAction(act: .sunroofOpen)
print(audiTT.color)
print(audiTT.engineIsOn())
audiTT.doAction(act: .engineStart)
print(audiTT.engineIsOn())
print(audiTT)

class TrunkCar: Car {
    var manufacturer: Manufacturer
    var year: Int
    var transmission: Transmission
    var color: Color
    var engineState: EngineState = .off
    var windowsState: WindowsState = .closed
    let cargoVolume: Int
    private(set) var cargoUsedSpace: Int = 0
    
    func freeSpace() -> Int {
        return cargoVolume - cargoUsedSpace
    }
    
    func doAction(act: CarAction) {
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
        default:
            print(Errors.actionNotAvailable.rawValue)
        }
    }
    
    required init(manufacturer: Manufacturer, year: Int, transmission: Transmission, color: Color, cargoVolume: Int) {
        self.manufacturer = manufacturer
        self.year = year
        self .transmission = transmission
        self .color = color
        self.cargoVolume = cargoVolume
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Грузовой автомобиль марки \(manufacturer.rawValue) \(year) года выпуска.\nКоробка передач: \(transmission.rawValue)\nДвигатель: \(engineState == .on ? "включен" : "выключен")\nОкна: \(windowsState == .opened ? "открыты" : "закрыты")\nОбъём кузова: \(cargoVolume) л\nЗагрузка: \(cargoUsedSpace) л"
    }
}

var scania20T = TrunkCar(manufacturer: .scania, year: 2019, transmission: .manual, color: .red, cargoVolume: 20000)
scania20T.doAction(act: .addCargo(volume: 7500))
print(scania20T.freeSpace())
scania20T.doAction(act: .removeCargo(volume: 1000))
print(scania20T.freeSpace())
scania20T.doAction(act: .windowsOpen)
scania20T.doAction(act: .sunroofOpen)
print(scania20T)
