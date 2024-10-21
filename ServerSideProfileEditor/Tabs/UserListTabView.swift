//
//  UserListTabView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

struct UserListTabView: View {

  @State private var routerPath = RouterPath()
  @Environment(UserListManager.self) var userList

  var body: some View {
    NavigationStack(path: $routerPath.path) {
      UserListView()
        .withAppRouter()
    }
    .environment(userList)
    .environment(routerPath)
  }
}

#Preview {
  UserListTabView()
    .withStubbedEnviorments()
}
