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
          .environment(UserDatabase.shared)
      case .userInfoEditor(let user, let updatedUserClosure):
          ProfileEditorView(initialUser: user, userDidUpdate: updatedUserClosure)
        .environment(UserDatabase.shared)
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
    environment(UserDatabase.shared)
      .environment(Theme())
      .environment(RouterPath())
  }

  func withStubbedEnviorments() -> some View {
    environment(UserDatabase.shared)
      .environment(Theme())
      .environment(RouterPath())
  }
}
