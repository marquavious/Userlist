//
//  View+Ext.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

@MainActor
extension View {
  func withAppRouter() -> some View {
    navigationDestination(for: RouterDestination.self) { destination in
      switch destination {
      case .profile(let id):
        ProfileView(id: id)
      }
    }
  }
}

extension View {
  func withStubbedEnviorments() -> some View {
    environment(UserListManager())
      .environment(Theme())
      .environment(RouterPath())
  }
}
