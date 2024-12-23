//
//  ProfileEditorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct ProfileEditorView: View {

  @Environment(\.dismiss) var dismiss

  private enum TextField: CaseIterable, Identifiable {
    case username
    case description
    case profilePictureUrl
    case bannerPictureUrl

    var id: String {
      UUID().uuidString
    }

    var title: String {
      switch self {
      case .username:
        "Username:"
      case .description:
        "Description:"
      case .profilePictureUrl:
        "Profile Picture Url:"
      case .bannerPictureUrl:
        "Header Profile Picture Url:"
      }
    }

    var prompt: String {
      switch self {
      case .username:
        "Username..."
      case .description:
        "Description..."
      case .profilePictureUrl, .bannerPictureUrl:
        "URL..."
      }
    }

    var isRequired: Bool {
      switch self {
      case .username:
        true
      case .description:
        false
      case .profilePictureUrl:
        true
      case .bannerPictureUrl:
        true
      }
    }
  }

  @State private var usernameText = ""
  @State private var descriptionText = ""
  @State private var profilePictureURL = ""
  @State private var bannerPhotoURL = ""
  @State private var showChanges: Bool = true
  @FocusState private var focusedTextField: TextField?

  private var initialViewState: ProfileEditorViewState
  private var updatedViewState: ProfileEditorViewState
  private var userDidUpdate: UserDidUpdate

  private var changeExists: Bool {
    initialViewState.usernameText != usernameText ||
    initialViewState.descriptionText != descriptionText ||
    initialViewState.profilePictureURL != profilePictureURL ||
    initialViewState.bannerPhotoURL != bannerPhotoURL
  }

  init(initialUser: UserData, userDidUpdate: @escaping UserDidUpdate) {
    self.userDidUpdate = userDidUpdate
    self.updatedViewState = .init(userData: initialUser)
    self.initialViewState = .init(userData: initialUser)
  }

  var body: some View {
    List {
      Section("Preview") {
        HStack {
          PhotoView(url: URL(string: profilePictureURL))
            .frame(
              width: StyleConstants.MediaSizes.ProfilePicture.profilePictureWidth,
              height: StyleConstants.MediaSizes.ProfilePicture.profilePictureHeight
            )
            .clipShape(Circle())
          PhotoView(url: URL(string: profilePictureURL))
            .frame(
              height: StyleConstants.MediaSizes.ProfilePicture.profilePictureHeight
            )
            .clipShape(RoundedRectangle(cornerRadius: StyleConstants.Geometry.cornerRadius))
        }
      }

      /* Sigh...
      Section("Text Edit") {
        VStack {
          ForEach(TextField.allCases) { textField in
            CustomTextField(
              title: textField.title,
              textfieldPrompt: textField.prompt,
              isRequired: textField.isRequired,
              text: createBindingFor(textField: textField)
            )
            .environment(\.isFocused, focusedTextField == textField)
            .focused($focusedTextField, equals: textField)
          }
        }
      }
      .disabled(!showChanges)
      */

      Section("Text Edit") {
        VStack {
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
            title: "Profile Picture URL",
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
          .environment(\.isFocused, focusedTextField == .bannerPictureUrl)
          .focused($focusedTextField, equals: .bannerPictureUrl)
        }
      }
      .disabled(!showChanges)

      Section("Control Panel") {
        ToggleStateControlPanel(
          title: "Show Updates",
          showChanges: $showChanges,
          rightButtonText: changeExists ? "Discard Changes" : "Dismiss",
          leftButtonPressed: {
            didUpdateUser()
          },
          rightButtonPressed: {
            if changeExists {
              showChanges = true
              setViewFor(state: initialViewState)
            } else {
              dismiss()
            }
          }
        )
      }
    }
    .onChange(of: usernameText) { _, newValue in
      if showChanges {
        updatedViewState.usernameText = newValue
      }
    }
    .onChange(of: descriptionText) { _, newValue in
      if showChanges {
        updatedViewState.descriptionText = newValue
      }
    }
    .onChange(of: profilePictureURL) { _, newValue in
      if showChanges {
        updatedViewState.profilePictureURL = newValue
      }
    }
    .onChange(of: bannerPhotoURL) { _, newValue in
      if showChanges {
        updatedViewState.bannerPhotoURL = newValue
      }
    }
    .onChange(of: showChanges) {
      refreshViewState()
    }
    .onAppear {
      refreshViewState()
    }
  }

  private func refreshViewState() {
    setViewFor(state: showChanges ? updatedViewState : initialViewState)
  }

  private func setViewFor(state: ProfileEditorViewState) {
    usernameText = state.usernameText
    descriptionText = state.descriptionText
    profilePictureURL = state.profilePictureURL
    bannerPhotoURL = state.bannerPhotoURL
  }

  private func didUpdateUser() {
    userDidUpdate(
      UserData(
        username: usernameText,
        description: descriptionText,
        profilePictureUrlString: profilePictureURL,
        profileHeaderUrlString: bannerPhotoURL
      )
    )
  }

  /*
  private func createBindingFor(textField: TextField) -> Binding<String> {
    switch textField {
    case .username:
      Binding(get: { usernameText }, set: { usernameText = $0 })
    case .description:
      Binding(get: { descriptionText }, set: { descriptionText = $0 })
    case .profilePictureUrl:
      Binding(get: { profilePictureURL }, set: { profilePictureURL = $0 })
    case .bannerPictureUrl:
      Binding(get: { bannerPhotoURL }, set: { bannerPhotoURL = $0 })
    }
  }
  */
}

#Preview {
  ProfileEditorViewForPreviews()
}
