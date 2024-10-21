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
  
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(userList.users) { user in
          VStack(alignment: .leading) {
            HStack {
              AsyncImage(url: user.userInfo.profilePictureUrl) { image in
                image
                  .resizable()
                  .scaledToFit()
              } placeholder: {
                Color.secondary
              }
              .frame(width: 60, height: 60)
              .background(.background)
              .background(.gray)
              .clipShape(Circle())
              .overlay(Circle().stroke(.gray, lineWidth: 1))

              VStack(alignment: .leading) {
                Text(user.userInfo.username)
                  .font(Theme.Text.title.font)
                  .bold()
                Text("_\(user.userInfo.description)_")
                  .font(Theme.Text.description.font)
                  .lineLimit(3)
              }
            }
            .padding(.horizontal, 16)
            Divider()
          }
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    UserListView()
      .environment(UserListManager())
      .environment(Theme())
      .navigationTitle("Userlist")
  }
}
