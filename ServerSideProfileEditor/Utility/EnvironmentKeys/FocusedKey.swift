//
//  FocusedKey.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import Foundation
import SwiftUI

private struct FocusedKey: EnvironmentKey {
  static let defaultValue: Bool = false
}

extension EnvironmentValues {
  var isFocused: Bool {
    get { self[FocusedKey.self] }
    set { self[FocusedKey.self] = newValue }
  }
}
