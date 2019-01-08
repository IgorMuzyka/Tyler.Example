
import Foundation

internal struct Loop<Element>: Sequence, IteratorProtocol {

    private let array: [Element]
    private var nextIndex: Int = 0

    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        array = Array(sequence)
    }

    public subscript(index: Int) -> Element {
        if index > array.count {
            return array[index % array.count]
        } else if index < 0 {
            if labs(index) >= array.count {
                return self[index + array.count]
            } else {
                return array[array.count + index]
            }
        } else {
            return array[index % array.count]
        }
    }

    public var count: Int {
        return array.count
    }

    public mutating func next() -> Element? {
        if nextIndex >= array.count {
            nextIndex = nextIndex % array.count
        }
        return array[nextIndex + 1]
    }
}
