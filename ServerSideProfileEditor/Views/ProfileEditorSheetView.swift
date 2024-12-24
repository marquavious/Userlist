//
//  ProfileEditorSheetView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct ProfileEditorSheetView: View {

  @Environment(\.dismiss) var dismiss

  @State var router = RouterPath()
  @Binding var showProfileChanges: Bool
  @Binding var presentationDetent: PresentationDetent
  @State private var initialProfileDataViewInfo: ProfileEditorSheetViewState
  @State private var userData: UserData
  @State private var sectionData: [SectionData]

  private var didUpdateProfile: ((ProfileData) -> Void)
  private var saveButtonPressed: ((ProfileData) -> Void)

  private var changesExist: Bool {
    sectionData != initialProfileDataViewInfo.sectionData || userData != initialProfileDataViewInfo.userData
  }

  init(
    showProfileChanges: Binding<Bool>,
    profile: ProfileData,
    presentationDetent: Binding<PresentationDetent>,
    didUpdateProfile: @escaping ((ProfileData) -> Void),
    saveButtonPressed: @escaping ((ProfileData) -> Void)
  ) {
    self._showProfileChanges = showProfileChanges
    self.userData = profile.user
    self.sectionData = profile.sections
    self._presentationDetent = presentationDetent
    self.didUpdateProfile = didUpdateProfile
    self.initialProfileDataViewInfo = .init(userData: profile.user, sectionData: profile.sections)
    self.saveButtonPressed = saveButtonPressed
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Section("Control Panel") {
          ToggleStateControlPanel(
            title: "Show Updates",
            showChanges: $showProfileChanges,
            rightButtonText: changesExist ? "Discard Changes" : "Dismiss",
            leftButtonPressed: {
              saveButtonPressed(.init(user: userData, sections: sectionData))
            }, rightButtonPressed: {
              if changesExist {
                userData = initialProfileDataViewInfo.userData
                sectionData = initialProfileDataViewInfo.sectionData
              } else {
                dismiss()
              }
            }
          )
        }
        if presentationDetent == .large {
          Section("User Details") {
            VStack(spacing: 8) {
              UserListViewCell(
                imageURL: URL(string: userData.profilePictureUrlString ?? ""),
                title: userData.username,
                description: userData.description
              ).onTapGesture {
                router.navigate(to: .userInfoEditor(userData: userData) { updateUser(user: $0) })
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
          Section("Section Arrangement") {
            VStack {
              ForEach(sectionData) { section in
                ProfileEditorViewSectionCell(
                  title: section.title,
                  description: section.description,
                  media: section.media
                )
                .onTapGesture {
                  router.navigate(to: .sectionInfoEditor(sectionData: section) { updateSectionWith(id: section.id , newSection: $0) })
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
      }
      .listStyle(.sidebar)
      .scrollDismissesKeyboard(.interactively)
      .scrollIndicators(.hidden)
      .withAppRouter()
    }
    .onChange(of: userData) { oldValue, newValue in
      didUpdateProfile(.init(user: userData, sections: sectionData))
    }
    .onChange(of: sectionData) { oldValue, newValue in
      didUpdateProfile(.init(user: userData, sections: sectionData))
    }
    .environment(router)
  }

  private func updateUser(user: UserData) {
    self.userData = user
    _ = router.path.popLast()
  }

  private func updateSectionWith(id: String, newSection: SectionData) {
    if let index = sectionData.firstIndex(where: { $0.id == id }) {
      sectionData[index] = newSection
    } else {
      sectionData.append(newSection)
    }
    _ = router.path = []
  }
}

#Preview {
  ProfileEditorSheetViewForPreviews()
}
