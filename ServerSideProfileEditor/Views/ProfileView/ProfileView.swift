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
  @Environment(RouterPath.self) var router
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
      case .error(let description):
        Text("ERROR: \(description)")
      case .loading(let id):
        if let id {
          Text("LOADING (\(id)...")
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
            ProfileEditorSheetView(
              showProfileChanges: $showProfileChanges,
              profile: profile
            )
            .presentationBackground(.ultraThinMaterial)
            .presentationBackgroundInteraction(.enabled)
            .presentationDetents([.fraction(0.2), .large],
                                 selection: $sheetPresentationDetent)
            .interactiveDismissDisabled(true)
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

struct ProfileEditorSheetView: View {
  @State var router = RouterPath()
  @Binding var showProfileChanges: Bool
  @State var profile: Profile

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Section {
          VStack {
            Toggle(isOn: $showProfileChanges) {
              Text("Toggle Preview")
            }
            HStack {
              Button("Save") {
              }
              .modifier(ControlPanelButtonViewModifier(backgroundColor: .blue))
              Button("Discard Changes") {
              }
              .modifier(ControlPanelButtonViewModifier(backgroundColor: .red))
            }
          }.padding(.vertical, 8)
        }
        Section("User Details") {
          HStack {
            UserListViewCell(
              imageURL: profile.userInfo.profilePictureUrl,
              title: profile.userInfo.username,
              description: profile.userInfo.description
            )
          }
          .onTapGesture {
            router.navigate(to: .userInfoEditor(profile: profile))
          }
          .listRowSeparator(.hidden)
          .padding(.vertical, 8)
        }
        Section("Section Arangement") {
          VStack {
            ForEach(profile.sections) { sectionData in
              ProfileEditorViewSectionCell(
                title: sectionData.title,
                description: sectionData.description,
                media: sectionData.media
              )
              .listRowSeparator(.hidden)
            }
          }
          .padding(.vertical, 4)
        }
      }
      .listStyle(.sidebar)
      .scrollDismissesKeyboard(.interactively)
      .scrollIndicators(.hidden)
      .withAppRouter()
    }
    .environment(router)
  }
}
