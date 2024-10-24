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
    static let contentMarginsOffset: CGFloat = UIScreen.main.bounds.height * CGFloat(0.05)
    static let cellHorizontalPadding: CGFloat = 16
  }

  @Environment(UserListManager.self) var userlist
  @State var state: ProfileView.LoadingState

  @State var isInEditorMode: Bool = false
  @State var sheetPresentationDetent: PresentationDetent = PresentationDetent.fraction(0.2)
  @State var showProfileChanges: Bool = false
  @State var initalProfileData: Profile?
  @State var newProfileData: Profile?

  init(id: String) {
    self.state = .loading(id: id)
  }

  init(profile: Profile) {
    self.state = .loaded(profile: profile)
    self.initalProfileData = profile
    self.newProfileData = profile
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
            ) {
              isInEditorMode.toggle()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Constants.cellHorizontalPadding)
            Divider()
            ProfileViewArrangementSection(sections: profile.sections)
          }
        }
        .contentMargins(.bottom, isInEditorMode ? UIScreen.main.bounds.height * 0.2 : Constants.contentMarginsOffset)
        .sheet(isPresented: $isInEditorMode) {
          if let newProfileData {
            List {
              Section {
                Toggle(isOn: $showProfileChanges) {
                  Text("Toggle Preview")
                }

                Section("User Details") {
                  ProfileEditorView(
                    showProfileChanges: $showProfileChanges,
                    profile: newProfileData
                  )
                }
              }
            }
            .presentationBackground(.ultraThinMaterial)
            .presentationBackgroundInteraction(.enabled)
            .presentationDetents([.fraction(0.2), .large], selection: $sheetPresentationDetent)
            .interactiveDismissDisabled(true)
          } else {
            Text("Missing Fatal Error")
          }
        }
        .onChange(of: showProfileChanges) { ov, nv in
          if let initalProfileData, let newProfileData {
            withAnimation(.easeInOut(duration: 0.2)) {
              self.state = nv ? .loaded(profile: newProfileData) :
                .loaded(profile: initalProfileData)
            }
          }
        }
      }
    }
  }

  private func loadData(id: String) {
    if let profile = userlist.users.first(where: { $0.id == id }) {
      state = .loaded(profile: profile)
      self.initalProfileData = profile
      self.newProfileData = profile
    } else {
      state = .error(description: "User does not exist")
    }
  }
}

struct ProfileViewForPreviews: View {

  @State var profile = UserListManager.shared.users.randomElement()!

  var body: some View {
    ProfileView(profile: profile)
      .withStubbedEnviorments()
  }
}

#Preview {
  ProfileViewForPreviews()
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
          MediaView(
            media: media,
            height: Theme.MediaSizes.mediaHeight.height,
            cornerRadius: Theme.Geomitry.cornerRadius.radius
          )
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, Theme.Spacing.intraSectionalHorizontalSpacing.spacing / 2)
    }
  }
}

struct PhotoGridView: View {
  @State var height: CGFloat
  @State var cornerRadius: CGFloat
  @State var photoDataOne: PhotoData
  @State var photoDataTwo: PhotoData
  @State var photoDataThree: PhotoData
  @State var photoDataFour: PhotoData

  var body: some View {
    HStack {
      CustomContentModeImageView(
        urlString: photoDataOne.urlString,
        contentMode: photoDataOne.contentMode
      )
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      CustomContentModeImageView(
        urlString: photoDataTwo.urlString,
        contentMode: photoDataTwo.contentMode
      )
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    .frame(height: height / 2)
    HStack {
      CustomContentModeImageView(
        urlString: photoDataThree.urlString,
        contentMode: photoDataThree.contentMode
      )
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      CustomContentModeImageView(
        urlString: photoDataFour.urlString,
        contentMode: photoDataFour.contentMode
      )
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    .frame(height: height / 2)
  }
}

struct CustomContentModeImageView: View {

  var urlString: String?
  var contentMode: ContentMode

  var body: some View {
    Rectangle()
      .fill(.gray)
      .overlay {
        if contentMode == .fit {
          ZStack {
            AsyncImage(url: URL(string: urlString ?? "")) { image in
              Rectangle()
                .fill(.clear)
                .overlay {
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 5)
                }
            } placeholder: {
              Color.gray
            }
            .background(.gray)
            .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))

            AsyncImage(url: URL(string: urlString ?? "")) { image in
              image
                .resizable()
                .aspectRatio(contentMode: contentMode)
            } placeholder: {
              Color.gray
            }
            .background(.gray)
          }
        } else {
          AsyncImage(url: URL(string: urlString ?? "")) { image in
            image
              .resizable()
              .aspectRatio(contentMode: contentMode)
          } placeholder: {
            Color.gray
          }
          .background(.gray)
          .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
        }
      }
  }
}

struct ProfileViewUserInfoSection: View {

  var username: String
  var description: String?
  var profilePictureUrl: URL?
  var imageSize: CGSize = CGSize(width: 60, height: 60)

  var editButtonPressed: (() -> Void)

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

      HStack {
        Text("\(username) •")
          .font(.headline)
        Button("Edit Profile") {
          editButtonPressed()
        }.buttonStyle(.automatic)
        Spacer()
      }.frame(maxWidth: .infinity)

      if let description {
        Text(description)
          .font(.subheadline)
      }
    }
  }
}

struct MediaView: View {

  @State var media: Media
  @State var height: CGFloat
  @State var cornerRadius: CGFloat

  var body: some View {
    switch media {
    case .urlPhoto(let photoData):
      CustomContentModeImageView(urlString: photoData.urlString, contentMode: photoData.contentMode)
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    case .urlPhotoGrid(let photoDataOne, let photoDataTwo, let photoDataThree, let photoDataFour):
      PhotoGridView(
        height: height,
        cornerRadius: cornerRadius,
        photoDataOne: photoDataOne,
        photoDataTwo: photoDataTwo,
        photoDataThree: photoDataThree,
        photoDataFour: photoDataFour
      )
    case .urlPhotoCarousel(photoArray: let photoArray):
      PhotoCarouselView(
        photoArray: photoArray,
        photoCornerRadius: Theme.Geomitry.cornerRadius.radius
      )
      .frame(height: height)
    }
  }
}

struct PhotoCarouselView: View {

  @State var photoArray: [PhotoData]
  @State var photoCornerRadius: CGFloat

  var body: some View {
    GeometryReader { proxy in
      ScrollView(.horizontal) {
        HStack {
          ForEach(photoArray) { image in
            CustomContentModeImageView(
              urlString: image.urlString,
              contentMode: image.contentMode
            )
            .frame(width: proxy.frame(in: .global).width)
            .clipShape(RoundedRectangle(cornerRadius: photoCornerRadius))
          }
        }
        .scrollTargetLayout()
      }
      .scrollTargetBehavior(.viewAligned)
      .scrollIndicators(.hidden)
    }
    .scrollClipDisabled()
  }
}


struct ProfileEditorView: View {

  @Binding var showProfileChanges: Bool
  @State var profile: Profile

  var body: some View {

      Section {
        HStack {
          AsyncImage(url: profile.userInfo.profilePictureUrl) { image in
            image
              .resizable()
              .scaledToFit()
          } placeholder: {
            Color.secondary
          }
          .frame(
            width: Theme.MediaSizes.profilePicture.width,
            height: Theme.MediaSizes.profilePicture.height
          )
          .background(.background)
          .background(.gray)
          .clipShape(Circle())
          .overlay(Circle().stroke(.gray, lineWidth: 1))
          Spacer()
          AsyncImage(url: profile.userInfo.profilePictureUrl) { image in
            image
              .resizable()
              .scaledToFit()
          } placeholder: {
            Color.secondary
          }
          .scaledToFill()
          .frame(height: Theme.MediaSizes.profilePicture.height)
          .background(.gray)
          .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
        }
        .listRowSeparator(.hidden)
      }

  }
}
