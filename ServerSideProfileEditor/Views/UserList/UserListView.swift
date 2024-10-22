//
//  UserListView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

struct UserListView: View {
  
  @Environment(UserListManager.self) var userList
  @Environment(RouterPath.self) var router

  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(userList.users) { user in
          UserListViewCell(
            imageURL: user.userInfo.profilePictureUrl,
            title: user.userInfo.username,
            description: user.userInfo.description
          )
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
}