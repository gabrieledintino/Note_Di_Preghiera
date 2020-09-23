//
//  Sequence-Extensions.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/09/2020.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
