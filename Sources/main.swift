// swift-generics-demo.swift

// ============ 泛型函数 ============
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 10, y = 20
swapValues(&x, &y)
print("x = \(x), y = \(y)")

var s1 = "Hello", s2 = "World"
swapValues(&s1, &s2)
print("s1 = \(s1), s2 = \(s2)")

// ============ 泛型结构体 ============
struct Stack<T> {
    var items: [T] = []

    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop() -> T? {
        return items.popLast()
    }

    var top: T? {
        return items.last
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
print("栈顶: \(intStack.top!)")

var stringStack = Stack<String>()
stringStack.push("a")
stringStack.push("b")
print("栈顶: \(stringStack.top!)")

// ============ 泛型约束 ============
protocol Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool
}

func findMax<T: Comparable>(_ items: [T]) -> T? {
    guard var max = items.first else { return nil }
    for item in items {
        if item > max {
            max = item
        }
    }
    return max
}

let numbers = [3, 1, 4, 1, 5, 9, 2, 6]
if let max = findMax(numbers) {
    print("最大值: \(max)")
}

// ============ 泛型关联类型 ============
protocol Container {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct ArrayContainer<T>: Container {
    var items: [T] = []

    var count: Int { items.count }
    subscript(i: Int) -> T { items[i] }
}

let container = ArrayContainer(items: [1, 2, 3])
print("元素数量: \(container.count)")
print("第一个元素: \(container[0])")

// ============ 泛型 where 子句 ============
func process<T>(items: [T]) where T: Numeric {
    let sum = items.reduce(0, +)
    print("总和: \(sum)")
}

process(items: [1, 2, 3, 4, 5])

// ============ 泛型别名 ============
typealias StringDictionary<T> = [String: T]

var dict: StringDictionary<Int> = ["a": 1, "b": 2]
print("字典: \(dict)")
