//
// Copyright © 2018 EGGS Design. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
    /**
     Returns the unique entries in an array, ordered in the order they appear in the source array from first to last.
     */
    public var orderedSet: Array  {
        var array: [Element] = []
        return compactMap {
            if array.contains($0) {
                return nil
            } else {
                array.append($0)
                return $0
            }
        }
    }
}

public extension Array {
    /**
     Utility method for easily iterating through an array with access to the previous and next element in the array.
     */
    public func nearbyForEach(_ body: (_ index: Int, _ element: Element, _ prevElement: Element?, _ nextElement: Element?) -> Void) {
        for i in (0..<self.count) {
            let pIndex = i - 1
            let pElement: Element? = pIndex >= 0 ? self[pIndex] : nil
            
            let nIndex = i + 1
            let nElement: Element? = nIndex < self.count ? self[nIndex] : nil
            
            body(i, self[i], pElement, nElement)
        }
    }
}

public extension Sequence {
    /**
     Returns a dictionary of arrays grouped on a specific key.
     For example, it can be used to group events on the date they occurred, people by their age, etc.
     */
    public func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}

public extension Array where Iterator.Element == String {
    /**
     Use this method to easily join strings with an unique separator for the last element.
     Example: I like juice, milk *and* beer.
     */
    public func joined(separator: String, lastElementSeparator: String) -> String {
        guard case let allButLastElement = self.prefix(upTo: self.count - 1), self.count > 1 else {
            return self.first ?? ""
        }
        
        let lastElement = self.last ?? ""
        let lastElementContainsLastElementSeparator = lastElement.contains(lastElementSeparator)
        let actualLastElementSeparator = lastElementContainsLastElementSeparator ? separator : " \(lastElementSeparator)"
        return "\(allButLastElement.map({ $0.replacingOccurrences(of:  " \(lastElementSeparator)", with: separator)}).joined(separator: separator))\(actualLastElementSeparator)\(lastElement)"
    }
}

