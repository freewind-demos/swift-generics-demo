# Swift 泛型 Demo

## 简介

本 demo 展示 Swift 泛型的用法：泛型函数、结构体、约束。泛型是 Swift 最强大的特性之一，让我们能够写出**可复用且类型安全**的代码。

## 基本原理

### 什么是泛型？

泛型让我们能够写出**适用于多种类型**的代码，而不需要为每种类型写重复代码。

```swift
// 非泛型：只能交换 Int
func swapInt(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

// 泛型：可以交换任何类型
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
```

### 泛型的优势

| 优势 | 说明 |
|------|------|
| **代码复用** | 一套代码适用于多种类型 |
| **类型安全** | 编译时检查类型，减少运行时错误 |
| **性能** | 泛型通常比使用 Any 性能更好 |

### 泛型的原理

Swift 的泛型使用**静态分发**，在编译时就确定了具体类型：

```
泛型代码：
func swapValues<T>(_ a: inout T, _ b: inout T)

编译时展开为：
func swapValues(_ a: inout Int, _ b: inout Int)
func swapValues(_ a: inout String, _ b: inout String)
```

---

## 启动和使用

### 环境要求

- Swift 5.0+
- macOS 或 Linux

### 安装和运行

```bash
cd swift-generics-demo
swift run
```

---

## 教程

### 泛型函数

最基本的泛型用法：

```swift
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 10, y = 20
swapValues(&x, &y)
print("x = \(x), y = \(y)")  // x = 20, y = 10

var s1 = "Hello", s2 = "World"
swapValues(&s1, &s2)
print("s1 = \(s1), s2 = \(s2)")  // s1 = World, s2 = Hello
```

`<T>` 表示这是一个泛型函数，T 是类型参数。

### 泛型结构体

泛型可以用于结构体：

```swift
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

// 使用
var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
print("栈顶: \(intStack.top!)")

var stringStack = Stack<String>()
stringStack.push("a")
stringStack.push("b")
print("栈顶: \(stringStack.top!)")
```

### 泛型约束

有时我们需要限制泛型必须满足某些条件：

```swift
// 约束 T 必须遵循 Comparable 协议
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
    print("最大值: \(max)")  // 9
}
```

常用的约束：
- `T: Comparable` — 可比较
- `T: Equatable` — 可相等
- `T: Hashable` — 可哈希
- `T: Numeric` — 数值类型

### where 子句

更复杂的约束可以使用 `where` 子句：

```swift
// 约束 T 必须是 Numeric 类型
func process<T>(items: [T]) where T: Numeric {
    let sum = items.reduce(0, +)
    print("总和: \(sum)")
}

process(items: [1, 2, 3, 4, 5])
```

`where` 子句的优势是可以同时约束多个条件：

```swift
func process<T>(items: [T]) where T: Numeric, T: CustomStringConvertible {
    // T 既是数值类型，又可以转换为字符串
}
```

### 泛型关联类型

协议可以使用关联类型，让实现者决定具体类型：

```swift
protocol Container {
    associatedtype Item  // 由实现者决定类型
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
```

### 泛型别名

可以用 `typealias` 创建泛型别名：

```swift
typealias StringDictionary<T> = [String: T]

var dict: StringDictionary<Int> = ["a": 1, "b": 2]
print("字典: \(dict)")
```

---

## 关键代码详解

### 泛型的编译时展开

Swift 的泛型使用**静态分发**，编译器会为每种使用的类型生成专门的代码：

```swift
func swapValues<T>(_ a: inout T, _ b: inout T)
```

当使用 `swapValues(&x, &y)` 且 x, y 是 Int 时，编译器会生成：

```swift
func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}
```

这就是为什么泛型通常比使用 `Any` 性能更好——没有运行时类型检查的开销。

### 泛型约束的原理

```swift
func findMax<T: Comparable>(_ items: [T]) -> T?
```

这个约束告诉编译器：
- T 必须实现 Comparable 协议
- 因此 T 可以使用 `>` 操作符
- 编译器可以在编译时检查这一点

---

## 总结

泛型是 Swift 最重要的特性之一：

1. **代码复用** — 一套代码适用于多种类型
2. **类型安全** — 编译时检查类型错误
3. **高性能** — 静态分发，无运行时开销

泛型的使用场景：
- 集合类型（Array、Dictionary、Set）
- 通用算法（排序、查找）
- 依赖注入
- 类型安全的容器
