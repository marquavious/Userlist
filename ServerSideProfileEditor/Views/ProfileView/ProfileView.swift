//
//  ProfileView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import SwiftUI

struct ProfileView: View {

  private enum LoadingState: Equatable {
    case loading(id: String?)
    case loaded(profile: ProfileData)
    case error(description: String)
  }

  private struct Constants {
    static let profilePictureSize: CGSize = CGSize(width: Theme.MediaSizes.profilePicture.width, height: Theme.MediaSizes.profilePicture.height)
    static let profileHeaderPictureHeight: CGFloat = UIScreen.main.bounds.height * CGFloat(0.2)
    static let contentMarginBottomOffset: CGFloat = UIScreen.main.bounds.height * CGFloat(0.05)
    static let contentMarginsOffsetForEditingMode: CGFloat = UIScreen.main.bounds.height * CGFloat(0.2)
    static let cellHorizontalPadding: CGFloat = Theme.Padding.profileViewHorizontalSpacing.padding
  }

  @State private var newProfileData: ProfileData?
  @State private var initalProfileData: ProfileData?
  @State private var state: ProfileView.LoadingState
  @State private var isInEditorMode: Bool = false
  @State private var showProfileChanges: Bool = false
  @State private var sheetPresentationDetent: PresentationDetent = PresentationDetent.fraction(0.0)
  @Environment(UserDatabase.self) private var userlist
  @Environment(RouterPath.self) private var router

  init(id: String) {
    state = .loading(id: id)
  }

  init(profile: ProfileData) {
    state = .loaded(profile: profile)
    initalProfileData = profile
    newProfileData = profile
  }

  var body: some View {
    Group {
      switch state {
      case .error(let description):
        Text("ERROR: \(description)")
      case .loading(let id):
        if let id {
          Text("LOADING (\(id)...")
            .onAppear {
              loadData(id: id)
            }
        } else {
          fatalError("Profile with ID not Found")
        }
      case .loaded(let profile):
        StretchyHeaderScrollView(
          url: URL(string: profile.user.profileBannerUrlString ?? ""),
          photoHeight: Constants.profileHeaderPictureHeight,
          verticalOffset: -Constants.profilePictureSize.height / 1.5
        ) {
          VStack {
            ProfileViewUserInfoSection(
              username: profile.user.username,
              description: profile.user.description,
              profilePictureUrl: URL(string: profile.user.profilePictureUrlString ?? ""),
              editButtonPressed: {
                isInEditorMode.toggle()
              }
            )
            .padding(.horizontal, Constants.cellHorizontalPadding)
            .padding(.vertical, Constants.cellHorizontalPadding / 2)
            Divider()
            ProfileViewArrangementSection(sections: profile.sections)
          }
        }
        .sheet(isPresented: $isInEditorMode) {
          ProfileEditorSheetView(
            showProfileChanges: $showProfileChanges,
            profile: profile,
            presentationDetent: $sheetPresentationDetent,
            didUpdateProfile: { updatedProfile in
              self.newProfileData = updatedProfile
              self.showProfileChanges = true
              self.state = .loaded(profile: updatedProfile)
            },
            saveButtonPressed: { updatedProfile in
              self.newProfileData = updatedProfile
              self.initalProfileData = updatedProfile
              self.state = .loaded(profile: updatedProfile)
              self.isInEditorMode = false
            }
          )
          .presentationBackground(.ultraThinMaterial)
          .presentationBackgroundInteraction(.enabled)
          .presentationDetents([.fraction(0.2), .large], selection: $sheetPresentationDetent)
          .interactiveDismissDisabled(true)
        }
        .onChange(of: showProfileChanges) { _, nv in
          if let initalProfileData, let newProfileData {
            withAnimation(.easeInOut(duration: Theme.AnimationSpeed.normal.rawValue)) {
              self.state = nv ? .loaded(profile: newProfileData) : .loaded(profile: initalProfileData)
            }
          }
        }
        .contentMargins(.bottom, isInEditorMode ? Constants.contentMarginsOffsetForEditingMode : Constants.contentMarginBottomOffset)
      }
    }
  }

  private func loadData(id: String) {
    if let profile = userlist.allUsers.first(where: { $0.id == id }) {
      state = .loaded(profile: profile)
      initalProfileData = profile
      newProfileData = profile
    } else {
      state = .error(description: "User does not exist")
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
