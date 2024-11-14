//
//  ProfileView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import SwiftUI

struct ProfileView: View {

  private enum LoadingState: Equatable {
    case loading(id: String?), loaded(profile: Profile), error(description: String)
  }

  private struct Constants {
    static let profilePictureSize: CGSize = CGSize(width: 95, height: 95)
    static let profileHeaderPictureHeight: CGFloat = UIScreen.main.bounds.height * CGFloat(0.2)
    static let contentMarginsOffset: CGFloat = UIScreen.main.bounds.height * CGFloat(0.05)
    static let contentMarginsOffsetForEditingMode: CGFloat = UIScreen.main.bounds.height * CGFloat(0.2)
    static let cellHorizontalPadding: CGFloat = 16
  }

  @State private var newProfileData: Profile?
  @State private var initalProfileData: Profile?
  @State private var isInEditorMode: Bool = false
  @State private var state: ProfileView.LoadingState
  @State private var showProfileChanges: Bool = false
  @State private var sheetPresentationDetent: PresentationDetent = PresentationDetent.fraction(0.2)
  @Environment(UserListManager.self) private var userlist
  @Environment(RouterPath.self) private var router

  init(id: String) {
    state = .loading(id: id)
  }

  init(profile: Profile) {
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
          url: profile.userInfo.profileHeaderUrl,
          photoHeight: Constants.profileHeaderPictureHeight,
          verticalOffset: -Constants.profilePictureSize.height / 1.6
        ) {
          VStack {
            ProfileViewUserInfoSection(
              username: profile.userInfo.username,
              description: profile.userInfo.description,
              profilePictureUrl: profile.userInfo.profilePictureUrl,
              imageSize: Constants.profilePictureSize,
              editButtonPressed: {
                isInEditorMode.toggle()
              }
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Constants.cellHorizontalPadding)
            .padding(.vertical, Constants.cellHorizontalPadding / 2)
            Divider()
            ProfileViewArrangementSection(sections: profile.sections)
          }
        }
        .contentMargins(.bottom, isInEditorMode ? Constants.contentMarginsOffsetForEditingMode : Constants.contentMarginsOffset)
        .sheet(isPresented: $isInEditorMode) {
          ProfileEditorSheetView(
            showProfileChanges: $showProfileChanges,
            profile: profile,
            didUpdateProfile: { updatedProfile in
              self.newProfileData = updatedProfile
              self.showProfileChanges = true
              self.state = .loaded(profile: updatedProfile)
            },
            saveButtonPressed: { updatedProfile in
              self.newProfileData = updatedProfile
              self.initalProfileData = updatedProfile
              self.state = .loaded(profile: updatedProfile)
              self.isInEditorMode.toggle()
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
      }
    }
  }

  private func loadData(id: String) {
    if let profile = userlist.users.first(where: { $0.id == id }) {
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
