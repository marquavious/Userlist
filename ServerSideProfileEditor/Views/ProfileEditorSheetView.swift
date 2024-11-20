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
  @State private var initialProfileDataViewInfo: ProfileEditorSheetViewState
  @State private var userData: User
  @State private var sectionData: [SectionData]

  var didUpdateProfile: ((Profile) -> Void)
  var saveButtonPressed: ((Profile) -> Void)

  init(showProfileChanges: Binding<Bool>, profile: Profile, didUpdateProfile: @escaping ((Profile) -> Void), saveButtonPressed: @escaping ((Profile) -> Void)) {
    self._showProfileChanges = showProfileChanges
    self.userData = profile.userInfo
    self.sectionData = profile.sections
    self.didUpdateProfile = didUpdateProfile

    self.initialProfileDataViewInfo = ProfileEditorSheetViewState(
      userData: profile.userInfo,
      sectionData: profile.sections
    )
    self.saveButtonPressed = saveButtonPressed
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Section {
          ToggleStateControlPanel(title: "Show Updates", showChanges: $showProfileChanges) {
            saveButtonPressed(.init(id: UUID().uuidString, userInfo: userData, sections: sectionData))
          } discardChangesPressed:  {
            userData = initialProfileDataViewInfo.userData
            sectionData = initialProfileDataViewInfo.sectionData
          }
        }
        Section("User Details") {
          VStack(spacing: 8) {
            UserListViewCell(
              imageURL: userData.profilePictureUrl,
              title: userData.username,
              description: userData.description
            ).onTapGesture {
              router.navigate(
                to: .userInfoEditor(
                  user: userData,
                  updatedUserClosure: { user in
                    userData = user
                    _ = router.path.popLast()
                  }
                )
              )
            }
            if initialProfileDataViewInfo.userData != userData {
              Divider()
              Button {
                userData = initialProfileDataViewInfo.userData
              } label: {
                Text("Discard Changes")
                  .contentShape(Rectangle())
                  .foregroundStyle(.blue)
              }
              .buttonStyle(.bordered)
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

            if initialProfileDataViewInfo.sectionData != sectionData {
              Divider()
              Button {
                sectionData = initialProfileDataViewInfo.sectionData
              } label: {
                Text("Discard Changes")
                  .contentShape(Rectangle())
                  .foregroundStyle(.blue)
              }
              .buttonStyle(.bordered)
            }
          }
        }
      }
      .listStyle(.sidebar)
      .scrollDismissesKeyboard(.interactively)
      .scrollIndicators(.hidden)
      .withAppRouter()
    }
    .onChange(of: userData) { oldValue, newValue in
      didUpdateProfile(.init(id: UUID().uuidString, userInfo: userData, sections: sectionData))
    }
    .onChange(of: sectionData) { oldValue, newValue in
      didUpdateProfile(.init(id: UUID().uuidString, userInfo: userData, sections: sectionData))
    }
    .environment(router)
  }
}

#Preview {
  ProfileEditorSheetViewForPreviews()
}
