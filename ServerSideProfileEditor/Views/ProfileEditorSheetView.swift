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
  var profile: Profile
  var sectionData: [SectionData]

  init(
    profile: Profile,
    sectionData: [SectionData]
  ) {
    self.profile = profile
    self.sectionData = sectionData
  }
  func copyState(_ state: ProfileEditorSheetViewInfo) {
    profile = state.profile
    sectionData = state.sectionData
  }
}

struct ProfileEditorSheetView: View {
  @State var router = RouterPath()
  @Binding var showProfileChanges: Bool
  @State private var initialProfileDataViewInfo: ProfileEditorSheetViewInfo
  @State private var profile: Profile
  @State private var sectionData: [SectionData]

  init(showProfileChanges: Binding<Bool>, profile: Profile) {
    self._showProfileChanges = showProfileChanges
    self.profile = profile
    self.sectionData = profile.sections

    self.initialProfileDataViewInfo = ProfileEditorSheetViewInfo(
      profile: profile,
      sectionData: profile.sections
    )
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Section {
          ToggleStateControlPanel(title: "Show Updates", showChanges: $showProfileChanges) {

          } discardChangesPressed:  {
            profile = initialProfileDataViewInfo.profile
            sectionData = initialProfileDataViewInfo.sectionData
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
            if initialProfileDataViewInfo.profile.userInfo != profile.userInfo {
              Divider()
              Button {
                profile = initialProfileDataViewInfo.profile
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
    .onChange(of: profile) { oldValue, newValue in
      profile = newValue
    }
    .onChange(of: sectionData) { oldValue, newValue in
      sectionData = newValue
    }
    .environment(router)
  }
}

#Preview {
  ProfileEditorSheetViewForPreviews()
}
