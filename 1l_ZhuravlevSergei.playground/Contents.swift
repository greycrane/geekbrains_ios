import UIKit

//Задание 1

var a: Int = 3
var b: Int = 5
var c: Int = 2

var x1, x2: Int?
var d: Int

print("1. Решить уравнение: \(a)x*x+\(b)x+\(c)=0")

d = b*b - 4*a*c

x1 = ((-1)*b + Int(sqrt(Double(d)))) / (2*a)
x2 = ((-1)*b - Int(sqrt(Double(d)))) / (2*a)

if x1 != nil, x2 != nil {
    print("Ответ: x1 = \(x1!), x2 = \(x2!)\n")
}

//Задание 2

a = 3
b = 4

print("2. Дан прямоугольный треугольник с катетами a=\(a) b=\(b). Найти гипотенузу(с), периметр(P) и площадь(S) треугольника.")

var s: Int?
var p: Int?

c = Int(sqrt(Double(a*a) + Double(b*b)))
s = (a + b) / 2
p = a + b + c

if s != nil, p != nil {
    print("Ответ: c=\(c), P=\(p!), S=\(s!)\n")
}

//Задание 3

var bankAccount: Double = 1000.0
var period: UInt = 5
var percent: Double = 10.0

print("3. На банковском счету находится \(bankAccount) рублей. Годовой процент равен \(percent)%. Какая сумма будет на счете через \(period) лет?")

for _ in 0...(period-1) {
    bankAccount += ((bankAccount / 100) * percent)
}

print("Сумма на банковском будет равна \(bankAccount.rounded())")






