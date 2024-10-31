//
//  ProfileEditorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

@Observable
class ProfileEditorViewModel: ObservableObject {
  var switchOnStateText: ProfileEditorView.ProfileEditorStateTextProvider = ProfileEditorView.ProfileEditorStateTextProvider()
  var switchOffStateText: ProfileEditorView.ProfileEditorStateTextProvider = ProfileEditorView.ProfileEditorStateTextProvider()
}

struct ProfileEditorView: View {

  class ProfileEditorStateTextProvider {
    var usernameText: String = ""
    var descriptionText: String = ""
    var profilePictureURL: String = ""
    var bannerPhotoURL: String = ""

    init(
      usernameText: String = "",
      descriptionText: String = "",
      profilePictureURL: String = "",
      bannerPhotoURL: String = ""
    ) {
      self.usernameText = usernameText
      self.descriptionText = descriptionText
      self.profilePictureURL = profilePictureURL
      self.bannerPhotoURL = bannerPhotoURL
    }
  }

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

  @State private var usernameText = ""
  @State private var descriptionText = ""
  @State private var profilePictureURL = ""
  @State private var bannerPhotoURL = ""

  var switchOnStateText: ProfileEditorStateTextProvider = ProfileEditorStateTextProvider()
  var switchOffStateText: ProfileEditorStateTextProvider = ProfileEditorStateTextProvider()

  @State private var shouldShowChanges: Bool = true
  @FocusState private var focusedTextField: ProfileEditorTextField?

  var userDidUpdate: UpdatedUserClosure

  init(initialUser: User, userDidUpdate: @escaping UpdatedUserClosure) {
    self.userDidUpdate = userDidUpdate

    self.switchOffStateText = ProfileEditorStateTextProvider(
      usernameText: initialUser.username,
      descriptionText: initialUser.description,
      profilePictureURL: initialUser.profilePictureUrlString ?? "",
      bannerPhotoURL: initialUser.profileHeaderUrlString ?? ""
    )

    self.switchOnStateText = ProfileEditorStateTextProvider(
      usernameText: initialUser.username,
      descriptionText: initialUser.description,
      profilePictureURL: initialUser.profilePictureUrlString ?? "",
      bannerPhotoURL: initialUser.profileHeaderUrlString ?? ""
    )
  }

  var body: some View {
    List {
      Section {
        VStack {
          HStack {
            AsyncImage(url: URL(string: profilePictureURL)) { image in
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
            Spacer()
            AsyncImage(url: URL(string: bannerPhotoURL)) { image in
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

          CustomTextField(
            title: "Username",
            textfieldPrompt: "Username...",
            isRequired: true,
            text: $usernameText
          )
          .environment(\.isFocused, focusedTextField == .username)
          .focused($focusedTextField, equals: .username)
          .disabled(!shouldShowChanges)

          CustomTextField(
            title: "Description",
            textfieldPrompt: "Description...",
            isRequired: false,
            text: $descriptionText
          )
          .environment(\.isFocused, focusedTextField == .description)
          .focused($focusedTextField, equals: .description)
          .disabled(!shouldShowChanges)

          CustomTextField(
            title: "Profile Picure URL",
            textfieldPrompt: "URl...",
            iconSystemImageName: "link",
            isRequired: true,
            text: $profilePictureURL
          )
          .environment(\.isFocused, focusedTextField == .profilePictureUrl)
          .focused($focusedTextField, equals: .profilePictureUrl)
          .disabled(!shouldShowChanges)

          CustomTextField(
            title: "Banner Picure URL",
            textfieldPrompt: "URL...",
            iconSystemImageName: "link",
            isRequired: true,
            text: $bannerPhotoURL
          )
          .environment(\.isFocused, focusedTextField == .headerPictureUrl)
          .focused($focusedTextField, equals: .headerPictureUrl)
          .disabled(!shouldShowChanges)
        }
      }
      .listRowSeparator(.hidden)
      .listStyle(.sidebar)

      Section {
        ToggleStateControlPanel(
          title: "Show Updates",
          showChanges: $shouldShowChanges,
          saveButtonPressed: {
            didUpdateUser()
          },
          discardChangesPressed: {
            switchOnStateText.usernameText = switchOffStateText.usernameText
            switchOnStateText.descriptionText = switchOffStateText.descriptionText
            switchOnStateText.profilePictureURL = switchOffStateText.profilePictureURL
            switchOnStateText.bannerPhotoURL = switchOffStateText.bannerPhotoURL
            shouldShowChanges = true
            refreshTextFields()
          })
        .padding(.vertical, 8)
      }
      .listRowSeparator(.hidden)
      .listStyle(.sidebar)
    }
    .onChange(of: usernameText) { oldValue, newValue in
      if shouldShowChanges {
        switchOnStateText.usernameText = newValue
      }
    }
    .onChange(of: descriptionText) { oldValue, newValue in
      if shouldShowChanges {
        switchOnStateText.descriptionText = newValue
      }
    }
    .onChange(of: profilePictureURL) { oldValue, newValue in
      if shouldShowChanges {
        switchOnStateText.profilePictureURL = newValue
      }
    }
    .onChange(of: bannerPhotoURL) { oldValue, newValue in
      if shouldShowChanges {
        switchOnStateText.bannerPhotoURL = newValue
      }
    }
    .onAppear {
      refreshTextFields()
    }
    .onChange(of: shouldShowChanges) { oldValue, newValue in
      refreshTextFields()
    }
    .navigationTitle("User Information")
  }

  private func refreshTextFields() {
    if shouldShowChanges {
      usernameText = switchOnStateText.usernameText
      descriptionText = switchOnStateText.descriptionText
      profilePictureURL = switchOnStateText.profilePictureURL
      bannerPhotoURL = switchOnStateText.bannerPhotoURL
    } else {
      usernameText = switchOffStateText.usernameText
      descriptionText = switchOffStateText.descriptionText
      profilePictureURL = switchOffStateText.profilePictureURL
      bannerPhotoURL = switchOffStateText.bannerPhotoURL
    }
  }

  func didUpdateUser() {
    userDidUpdate(
      User(
        username: usernameText,
        description: descriptionText,
        profilePictureUrlString: profilePictureURL,
        profileHeaderUrlString: bannerPhotoURL
      )
    )
  }
}

struct ProfileEditorViewPreview: View {
  @State var showProfileChanges: Bool = false
  @State var profile: User = User.stubs().first!
  @State var updatedProfile: User = User.stubs().last!
  var body: some View {

      ProfileEditorView(
        initialUser: profile,
        userDidUpdate: { _ in

        }
      )
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
