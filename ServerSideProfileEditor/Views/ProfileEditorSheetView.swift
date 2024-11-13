//
//  ProfileEditorSheetView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

@Observable
class ProfileEditorSheetViewInfo: ObservableObject, Identifiable {
  var userInfo: User
  var sectionData: [SectionData]

  init(
    userData: User,
    sectionData: [SectionData]
  ) {
    self.userInfo = userData
    self.sectionData = sectionData
  }
  func copyState(_ state: ProfileEditorSheetViewInfo) {
    userInfo = state.userInfo
    sectionData = state.sectionData
  }
}

struct ProfileEditorSheetView: View {
  @State var router = RouterPath()
  @Binding var showProfileChanges: Bool
  @State private var initialProfileDataViewInfo: ProfileEditorSheetViewInfo
  @State private var userInfo: User
  @State private var sectionData: [SectionData]

  var didUpdateProfile: ((Profile) -> Void)

  init(showProfileChanges: Binding<Bool>, profile: Profile, didUpdateProfile: @escaping ((Profile) -> Void)) {
    self._showProfileChanges = showProfileChanges
    self.userInfo = profile.userInfo
    self.sectionData = profile.sections
    self.didUpdateProfile = didUpdateProfile

    self.initialProfileDataViewInfo = ProfileEditorSheetViewInfo(
      userData: profile.userInfo,
      sectionData: profile.sections
    )
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Section {
          ToggleStateControlPanel(title: "Show Updates", showChanges: $showProfileChanges) {

          } discardChangesPressed:  {
            userInfo = initialProfileDataViewInfo.userInfo
            sectionData = initialProfileDataViewInfo.sectionData
          }
        }
        Section("User Details") {
          VStack(spacing: 8) {
            UserListViewCell(
              imageURL: userInfo.profilePictureUrl,
              title: userInfo.username,
              description: userInfo.description
            ).onTapGesture {
              router.navigate(
                to: .userInfoEditor(
                  user: userInfo,
                  updatedUserClosure: { user in
                    userInfo = user
                    _ = router.path.popLast()
                  }
                )
              )
            }
            if initialProfileDataViewInfo.userInfo != userInfo {
              Divider()
              Button {
                userInfo = initialProfileDataViewInfo.userInfo
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
    .onChange(of: userInfo) { oldValue, newValue in
      didUpdateProfile(.init(id: UUID().uuidString, userInfo: userInfo, sections: sectionData))
    }
    .onChange(of: sectionData) { oldValue, newValue in
      didUpdateProfile(.init(id: UUID().uuidString, userInfo: userInfo, sections: sectionData))
    }
    .environment(router)
  }
}

#Preview {
  ProfileEditorSheetViewForPreviews()
}
