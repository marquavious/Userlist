//
//  KeyboardIsFocusedKey.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import Foundation
import SwiftUI


private struct KeyboardIsFocusedKey: EnvironmentKey {
  static let defaultValue: Bool = false
}

extension EnvironmentValues {
  var isFocused: Bool {
    get { self[KeyboardIsFocusedKey.self] }
    set { self[KeyboardIsFocusedKey.self] = newValue }
  }
}
