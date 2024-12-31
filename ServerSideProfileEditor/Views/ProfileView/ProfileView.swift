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
    static let profilePictureSize: CGSize = CGSize(
      width: StyleConstants.MediaSizes.ProfilePicture.profilePictureWidth,
      height: StyleConstants.MediaSizes.ProfilePicture.profilePictureHeight
    )
    static let profileHeaderPictureHeight: CGFloat = UIScreen.main.bounds.height * CGFloat(0.25)
    static let contentMarginBottomOffset: CGFloat = UIScreen.main.bounds.height * CGFloat(0.05)
    static let contentMarginsOffsetForEditingMode: CGFloat = UIScreen.main.bounds.height * CGFloat(0.2)
    static let cellHorizontalPadding: CGFloat = StyleConstants.Padding.profileViewHorizontalSpacing
  }

  @Environment(\.dismiss) private var dismiss
  @Environment(\.colorScheme) private var colorScheme
  @Environment(UserDatabase.self) private var usersList
  @Environment(RouterPath.self) private var router
  @State private var newProfileData: ProfileData?
  @State private var initialProfileData: ProfileData?
  @State private var state: ProfileView.LoadingState
  @State private var showNavigationBar: Bool = false
  @State private var isInEditorMode: Bool = false
  @State private var showProfileChanges: Bool = false
  @State private var sheetPresentationDetent: PresentationDetent = PresentationDetent.fraction(0.0)
  @State private var scrollOffset: CGFloat = 0

  init(id: String) {
    state = .loading(id: id)
  }

  init(profile: ProfileData) {
    state = .loaded(profile: profile)
    initialProfileData = profile
    newProfileData = profile
  }

  var body: some View {
    Group {
      switch state {
      case .error(let description):
        VStack(spacing: 16) {
          Image(systemName: "exclamationmark.triangle.fill")
            .font(.system(size: 50))
            .foregroundColor(.red)

          Text("Error Loading Profile")
            .font(.title2)
            .fontWeight(.bold)

          Text(description)
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)

          Button(action: {
            if case .loading(let id) = state, let id {
              loadData(id: id)
            }
          }) {
            Label("Try Again", systemImage: "arrow.clockwise")
              .padding()
              .background(Color.accentColor)
              .foregroundColor(.white)
              .cornerRadius(10)
          }
          .modifier(ControlPanelButtonViewModifier(backgroundColor: .accentColor))
        }
        .padding()
        .frame(maxHeight: .infinity)
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
          verticalOffset: -Constants.profilePictureSize.height / 1.5,
          viewBuilder: {
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
                  self.initialProfileData = updatedProfile
                  self.state = .loaded(profile: updatedProfile)
                  self.isInEditorMode = false
                }
              )
              .presentationBackground(.ultraThinMaterial)
              .presentationBackgroundInteraction(.enabled)
              .presentationDetents([.fraction(0.2), .large], selection: $sheetPresentationDetent)
              .interactiveDismissDisabled(true)
              .navigationBarHidden(true)
            }
            .onChange(of: showProfileChanges) { _, nv in
              if let initialProfileData, let newProfileData {
                withAnimation(.easeInOut(duration: StyleConstants.AnimationSpeed.normal)) {
                  self.state = nv ? .loaded(profile: newProfileData) : .loaded(profile: initialProfileData)
                }
              }
            }
          },
          offsetDidChange: { scrollOffset = $0 }
        )
      }
    }
    .contentMargins(.bottom, isInEditorMode ? Constants.contentMarginsOffsetForEditingMode : Constants.contentMarginBottomOffset)
    .onChange(of: scrollOffset) {
      handleNavigationBarAnimation(scrollViewOffset: scrollOffset)
    }
    .overlay(alignment: .topLeading) {
      CustomNavBar(
        title: extractProfileName() ?? "",
        blurEffectStyle: colorScheme == .dark ? .dark : .light,
        showNavigationBar: $showNavigationBar
      )
    }
    .navigationBarHidden(true)
  }
  private func extractProfileName() -> String? {
    guard case let .loaded(profile) = state else { return nil }
    return profile.user.username
  }

  private func loadData(id: String) {
    if let profile = usersList.allUsers.first(where: { $0.id == id }) {
      state = .loaded(profile: profile)
      initialProfileData = profile
      newProfileData = profile
    } else {
      state = .error(description: "User does not exist")
    }
  }

  private func handleNavigationBarAnimation(scrollViewOffset: CGFloat) {
    if scrollViewOffset > (-Constants.profileHeaderPictureHeight + 100) {
      withAnimation(.easeInOut(duration: 0.2)) {
        showNavigationBar = false
      }
    } else if scrollViewOffset < Constants.profileHeaderPictureHeight {
      withAnimation(.easeInOut(duration: 0.2)) {
        showNavigationBar = true
      }
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
