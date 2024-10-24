//
//  ProfileEditorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct ProfileEditorView: View {

  enum ProfileEditorTextField: CaseIterable, Identifiable {
    case username
    case description
    case profilePictureUrl
    case headerPictureUrl

    var id: String {
      UUID().uuidString
    }

    var textFieldTitle: String {
      switch self {
      case .username:
        "Username:"
      case .description:
        "Description:"
      case .profilePictureUrl:
        "Profile Picture Url:"
      case .headerPictureUrl:
        "Header Profile Picture Url:"
      }
    }

    var textFieldPromt: String {
      switch self {
      case .username:
        "Username..."
      case .description:
        "Description..."
      case .profilePictureUrl, .headerPictureUrl:
        "Url..."
      }
    }
  }

  @Binding var showProfileChanges: Bool
  @State var profile: Profile
  @State var usernameText = ""
  @State var descriptionText = ""
  @State var profilePictureURL = ""
  @State var bannerPhotoURL = ""
  @FocusState var focusedTextField: ProfileEditorTextField?

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
          .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
        }
        .listRowSeparator(.hidden)

      VStack(spacing: 8) {
        CustomTextField(
          title: "Username",
          textfieldPrompt: "Username...",
          isRequired: true,
          text: $usernameText
        )
        .environment(\.isFocused, focusedTextField == .username)
        .focused($focusedTextField, equals: .username)

        CustomTextField(
          title: "Description",
          textfieldPrompt: "Description...",
          isRequired: false,
          text: $descriptionText
        )
        .environment(\.isFocused, focusedTextField == .description)
        .focused($focusedTextField, equals: .description)

        CustomTextField(
          title: "Profile Picure URL",
          textfieldPrompt: "URl...",
          iconSystemImageName: "link",
          isRequired: true,
          text: $profilePictureURL
        )
        .environment(\.isFocused, focusedTextField == .profilePictureUrl)
        .focused($focusedTextField, equals: .profilePictureUrl)

        CustomTextField(
          title: "Banner Picure URL",
          textfieldPrompt: "URL...",
          iconSystemImageName: "link",
          isRequired: true,
          text: $bannerPhotoURL
        )
        .environment(\.isFocused, focusedTextField == .headerPictureUrl)
        .focused($focusedTextField, equals: .headerPictureUrl)
      }
    }
  }
}

struct ProfileEditorViewPreview: View {
  @State var showProfileChanges: Bool = false
  var body: some View {
    List {
      ProfileEditorView(
        showProfileChanges: $showProfileChanges,
        profile: Profile.generatRandomProfile()
      ).listStyle(.sidebar)
    }
  }
}

#Preview {
  ProfileEditorViewPreview()
}

private struct FocusedKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
  var isFocused: Bool {
    get { self[FocusedKey.self] }
    set { self[FocusedKey.self] = newValue }
  }
}
