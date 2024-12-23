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
        ForEach(userList.allUsers) { userData in
          HStack {
            UserListViewCell(
              imageURL: userData.user.profilePictureUrlString?.urlValue,
              title: userData.user.username,
              description: userData.user.description
            )
          }
          .environment(router)
          .padding(.horizontal, StyleConstants.Padding.profileViewHorizontalSpacing)
          .onTapGesture {
            router.navigate(to: .profile(id: userData.id))
          }
        }
      }
    }
  }
}

#Preview {
  AppView()
    .withStubbedEnvironments()
}
