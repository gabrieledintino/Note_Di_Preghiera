//
//  Array-Extension.swift
//  Canta e Cammina
//
//  Created by Gabriele on 26/09/2020.
//

import Foundation

//extension Array where Element: Equatable {
//    mutating func removeElement(element: Element) {
//        if let index = indexOf ({ $0 == element }) {
//            removeAtIndex(index)
//        }
//    }
//}

extension Array where Element: Equatable {
    mutating func removeElement(element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}
