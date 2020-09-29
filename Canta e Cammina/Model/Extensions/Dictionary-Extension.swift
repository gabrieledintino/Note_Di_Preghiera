//
//  Dictionary-Extension.swift
//  Canta e Cammina
//
//  Created by Gabriele on 29/09/2020.
//

import Foundation

extension Dictionary {
    mutating func changeKey(from: Key, to: Key) {
        self[to] = self[from]
        self.removeValue(forKey: from)
    }
}
