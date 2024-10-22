//
//  ProfileView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import SwiftUI

struct ProfileView: View {

  enum LoadingState: Equatable {
    case loading(id: String?), loaded(profile: Profile), error(description: String)
  }

  struct Constants {
    static let profilePictureSize: CGSize = CGSize(width: 95, height: 95)
    static let profileHeaderPictureHeight: CGFloat = UIScreen.main.bounds.height * CGFloat(0.2)
    static let contentMarginsOffset: CGFloat = UIScreen.main.bounds.height * CGFloat(0.2)
    static let cellHorizontalPadding: CGFloat = 16
  }

  @Environment(UserListManager.self) var userlist
  @State var state: ProfileView.LoadingState

  init(id: String) {
    self.state = .loading(id: id)
  }

  init(profile: Profile) {
    self.state = .loaded(profile: profile)
  }

  var body: some View {
    Group {
      switch state {
      case .error:
        Text("ERROR")
      case .loading(let id):
        if let id {
          Text("LOADING ID: \(id)")
            .onAppear {
              loadData(id: id)
            }
        }
      case .loaded(let profile):
        StretchyHeaderScrollView(
          url: profile.userInfo.profileHeaderUrl,
          photoHeight: Constants.profileHeaderPictureHeight,
          verticalOffset: -Constants.profilePictureSize.height / 1.6
        ) {
          ProfileViewUserInfoSection(
            username: profile.userInfo.username,
            description: profile.userInfo.description,
            profilePictureUrl: profile.userInfo.profilePictureUrl,
            imageSize: Constants.profilePictureSize
          )
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, Constants.cellHorizontalPadding)
        }
      }
    }
  }

  private func loadData(id: String) {
    if let profile = userlist.users.first(where: {$0.id == id }) {
      state = .loaded(profile: profile)
    } else {
      state = .error(description: "User does not exist")
    }
  }
}

#Preview {
  ProfileView(profile: Profile.generatRandomProfile())
    .withStubbedEnviorments()
}

struct ProfileViewUserInfoSection: View {

  var username: String
  var description: String?
  var profilePictureUrl: URL?

  var imageSize: CGSize = CGSize(width: 60, height: 60)

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {

      AsyncImage(url: profilePictureUrl) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        Color.secondary
      }
      .frame(width: imageSize.width, height: imageSize.height)
      .background(.background)
      .background(.gray)
      .clipShape(Circle())
      .overlay(Circle().stroke(.gray, lineWidth: 1))

      Text(username)
        .font(.headline)

      if let description {
        Text(description)
          .font(.subheadline)
      }
    }
  }
}
