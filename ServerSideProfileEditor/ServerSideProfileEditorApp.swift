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
      AppView()
    }
  }
}

struct AppView: View {
  var body: some View {
    TabView {
      UserListTabView()
        .tabItem {
          Label("Userlist", systemImage: "list.bullet")
        }
    }
    .withStubbedEnviorments()
  }
}

#Preview {
  AppView()
}
