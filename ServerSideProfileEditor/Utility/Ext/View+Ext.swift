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
          .environment(UserListManager.shared)
      case .userInfoEditor(let user, let _, let updatedUserClosure):
        List {
          ProfileEditorView(initialUser: user, userDidUpdate: updatedUserClosure)
        }
        .navigationTitle("User Information")
        .environment(UserListManager.shared)
      case .sectionInfoEditor(let section, let updatedSectionClosure):
        ProfileSectionEditorView(
          sectionData: section,
          sectionDidUpdate: updatedSectionClosure
        )
      }
    }
  }
}

extension View {

  func withEnvironments() -> some View {
    environment(UserListManager.shared)
      .environment(Theme())
      .environment(RouterPath())
  }

  // Foe Debug
  func withStubbedEnviorments() -> some View {
    environment(UserListManager.shared)
      .environment(Theme())
      .environment(RouterPath())
  }
}
