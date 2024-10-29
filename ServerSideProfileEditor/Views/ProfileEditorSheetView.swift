//
//  ProfileEditorSheetView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct ProfileEditorSheetView: View {
  @State var router = RouterPath()
  @Binding var showProfileChanges: Bool

  @State var shownProfile: Profile
  @State private var initialProfileData: Profile
  @State private var updatedProfileData: Profile

  init(showProfileChanges: Binding<Bool>, profile: Profile) {
    self._showProfileChanges = showProfileChanges
    self.shownProfile = profile
    self.initialProfileData = profile
    self.updatedProfileData = profile
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Section {
          ToggleStateControlPanel(title: "Show Updates", showChanges: $showProfileChanges) {
            
          }
        }
        Section("User Details") {
          HStack {
            UserListViewCell(
              imageURL: shownProfile.userInfo.profilePictureUrl,
              title: shownProfile.userInfo.username,
              description: shownProfile.userInfo.description
            )
          }
          .onTapGesture {
            router.navigate(
              to: .userInfoEditor(
                user: initialProfileData.userInfo,
                updatedUser: updatedProfileData.userInfo,
                updatedUserClosure: { user in
                  updatedProfileData.userInfo = user
                  _ = router.path.popLast()
                }
              )
            )
          }
          .listRowSeparator(.hidden)
          .padding(.vertical, 8)
        }
        Section("Section Arangement") {
          VStack {
            ForEach(shownProfile.sections) { sectionData in
              ProfileEditorViewSectionCell(
                title: sectionData.title,
                description: sectionData.description,
                media: sectionData.media
              )
              .onTapGesture {
                router.navigate(to:
                    .sectionInfoEditor(
                      section: sectionData,
                      updatedSectionClosure: { section in
                        _ = router.path.popLast()
                      })
                )
              }
              .listRowSeparator(.hidden)
            }
          }
          .padding(.vertical, 8)
        }
      }
      .listStyle(.sidebar)
      .scrollDismissesKeyboard(.interactively)
      .scrollIndicators(.hidden)
      .withAppRouter()
    }
    .environment(router)
    .onChange(of: showProfileChanges) { oldValue, newValue in
      if newValue {
        print("shownProfile", shownProfile)
        shownProfile = updatedProfileData
      } else {
        print("initialProfileData", initialProfileData)
        shownProfile = initialProfileData
      }
    }
  }
}

#Preview {
  ProfileEditorSheetViewForPreviews()
}
