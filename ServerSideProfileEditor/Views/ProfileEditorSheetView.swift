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

  @State private var profile: Profile
  @State private var sectionData: [SectionData]
  private var initialProfileData: Profile

  init(showProfileChanges: Binding<Bool>, profile: Profile) {
    self._showProfileChanges = showProfileChanges
    self.profile = profile
    self.initialProfileData = profile
    self.sectionData = profile.sections
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Section {
          ToggleStateControlPanel(title: "Show Updates", showChanges: $showProfileChanges) {

          } discardChangesPressed:  {

          }
        }
        Section("User Details") {
          VStack(spacing: 8) {
            UserListViewCell(
              imageURL: profile.userInfo.profilePictureUrl,
              title: profile.userInfo.username,
              description: profile.userInfo.description
            ).onTapGesture {
              router.navigate(
                to: .userInfoEditor(
                  user: profile.userInfo,
                  updatedUserClosure: { user in
                    profile.userInfo = user
                    _ = router.path.popLast()
                  }
                )
              )
            }
            if initialProfileData.userInfo != profile.userInfo {
              Divider()
              Button("Discard Changes") {
                profile.userInfo.profilePictureUrlString = initialProfileData.userInfo.profilePictureUrlString
                profile.userInfo.profileHeaderUrlString = initialProfileData.userInfo.profileHeaderUrlString
                profile.userInfo.username = initialProfileData.userInfo.username
                profile.userInfo.description = initialProfileData.userInfo.description
              }
              .listRowSeparator(.hidden)
              .font(.system(size: 12))
              .buttonStyle(.plain)
            }
          }
        }
        Section("Section Arangement") {
          VStack {
            ForEach(sectionData) { section in
              ProfileEditorViewSectionCell(
                title: section.title,
                description: section.description,
                media: section.media
              )
              .onTapGesture {
                router.navigate(to:
                    .sectionInfoEditor(
                      section: section,
                      updatedSectionClosure: { newSection in
                        if let index = sectionData.firstIndex(where: { $0.id == section.id }) {
                          sectionData[index] = newSection
                        } else {
                          sectionData.append(newSection)
                        }
                        _ = router.path = []
                      })
                )
              }
              .listRowSeparator(.hidden)
            }

            if initialProfileData.sections != sectionData {
              Divider()
              Button("Discard Changes") {
                sectionData = initialProfileData.sections
              }
              .listRowSeparator(.hidden)
              .font(.system(size: 12))
              .buttonStyle(.plain)
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
  }
}

#Preview {
  ProfileEditorSheetViewForPreviews()
}
