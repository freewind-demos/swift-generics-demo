# Swift 泛型 Demo

## 简介

展示 Swift 泛型的用法：泛型函数、结构体、约束。

## 启动和使用

```bash
cd swift-generics-demo
swift run
```

## 教程

### 泛型优势

- 代码复用
- 类型安全
- 减少重复代码

### 泛型约束

```swift
func funcName<T: SomeProtocol>(param: T)
```

### where 子句

```swift
func process<T>(items: [T]) where T: Numeric
```
