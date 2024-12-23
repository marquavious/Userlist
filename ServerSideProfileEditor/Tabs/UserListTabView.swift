//
//  UserListTabView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

struct UserListTabView: View {

  @Environment(UserDatabase.self) var userList
  @State private var routerPath = RouterPath()

  var body: some View {
    NavigationStack(path: $routerPath.path) {
      UserListView()
        .withAppRouter()
        .navigationTitle("Userlist")
    }
    .environment(userList)
    .environment(routerPath)
  }
}

#Preview {
  UserListTabView()
    .withStubbedEnvironments()
}
