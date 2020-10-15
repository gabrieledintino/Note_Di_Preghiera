//
//  Dictionary-Extension.swift
//  Canta e Cammina
//
//  Created by Gabriele on 29/09/2020.
//

import Foundation

extension Dictionary {
    mutating func changeKey(from: Key, to: Key) {
        let temp = self[from]
//        self[to] = self[from]
        self.removeValue(forKey: from)
        self[to] = temp
    }
}

extension Dictionary {
    mutating func switchKey(fromKey: Key, toKey: Key) {
        if let entry = removeValue(forKey: fromKey) {
            self[toKey] = entry
        }
    }
}
