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
          VStack {
            ProfileViewUserInfoSection(
              username: profile.userInfo.username,
              description: profile.userInfo.description,
              profilePictureUrl: profile.userInfo.profilePictureUrl,
              imageSize: Constants.profilePictureSize
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            ProfileViewArrangementSection(sections: profile.sections)
          }
          .padding(.horizontal, Constants.cellHorizontalPadding)
        }
        .contentMargins(.bottom, Constants.profilePictureSize.height / 1.6)
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

struct ProfileViewArrangementSection: View {

  var sections: [SectionData]
  var body: some View {
    ForEach(sections) { section in
      VStack(
        alignment: section.alignment.horizontalAlignment,
        spacing: Theme.Spacing.profileSectionCellSpacing.spacing
      ) {
        if let title = section.title {
          Text(title)
            .font(Theme.Text.title.font)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        if let description = section.description {
          Text(description)
            .font(Theme.Text.description.font)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        if let media = section.media {
          switch media {
          case .urlPhoto(let urlString):
            createImageView(urlString: urlString)
              .frame(height: section.mediaHeight ?? Theme.MediaSizes.mediaHeight.height)
              .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
          case .urlPhotoGrid(
            let urlStringOne,
            let urlStringTwo,
            let urlStringThree,
            let urlStringFour):
            VStack {
              HStack {
                createImageView(urlString: urlStringOne)
                  .frame(height: section.mediaHeight ?? Theme.MediaSizes.mediaHeight.height / 2)
                  .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
                  .clipped()
                createImageView(urlString: urlStringTwo)
                  .frame(height: section.mediaHeight ?? Theme.MediaSizes.mediaHeight.height / 2)
                  .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
                  .clipped()
              }
              .clipped()
              .frame(height: section.mediaHeight ?? Theme.MediaSizes.mediaHeight.height / 2)
              HStack {
                createImageView(urlString: urlStringThree)
                  .frame(height: section.mediaHeight ?? Theme.MediaSizes.mediaHeight.height / 2)
                  .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
                  .clipped()
                createImageView(urlString: urlStringFour)
                  .frame(height: section.mediaHeight ?? Theme.MediaSizes.mediaHeight.height / 2)
                  .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
                  .clipped()
              }
              .clipped()
              .frame(height: section.mediaHeight ?? Theme.MediaSizes.mediaHeight.height / 2)
            }
          }
        }
      }
      .padding(.vertical, Theme.Spacing.intraSectionalHorizontalSpacing.spacing / 2)
    }
  }

  private func createImageView(urlString: String?) -> some View {
    Rectangle()
      .fill(.gray)
      .overlay {
        AsyncImage(url: URL(string: urlString ?? "")) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
        } placeholder: {
          Color.gray
        }
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
      }
  }
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
