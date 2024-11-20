//
//  UserListView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

struct UserListView: View {
  
  @Environment(UserDatabase.self) var userList
  @Environment(RouterPath.self) var router

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(userList.allUsers) { user in
          HStack {
            UserListViewCell(
              imageURL: URL(string: user.user.profilePictureUrlString ?? ""),
              title: user.user.username,
              description: user.user.description
            )
          }
          .environment(router)
          .padding(.horizontal, 16)
          .onTapGesture {
            router.navigate(to: .profile(id: user.id))
          }
        }
      }
    }
  }
}

#Preview {
  AppView()
    .withStubbedEnviorments()
}
