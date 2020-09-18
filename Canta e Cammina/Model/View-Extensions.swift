//
//  View-Extensions.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 18/09/2020.
//

import Foundation
import SwiftUI

extension View {
  @ViewBuilder
  func `if`<Transform: View>(
    _ condition: Bool,
    transform: (Self) -> Transform
  ) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
