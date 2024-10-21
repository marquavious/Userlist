//
//  ServerSideProfileEditorApp.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import SwiftUI

@main
struct ServerSideProfileEditorApp: App {
  var body: some Scene {
    WindowGroup {
      UserListTabView()
        .withStubbedEnviorments()
    }
  }
}
