//
//  ServerSideProfileEditorApp.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import SwiftUI

@main
struct ServerSideProfileEditorApp: App {
  
  @State var userlist = UserDatabase.shared
  
  var body: some Scene {
    WindowGroup {
      AppView()
        .environment(userlist)
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
  }
}

#Preview {
  AppView()
}
