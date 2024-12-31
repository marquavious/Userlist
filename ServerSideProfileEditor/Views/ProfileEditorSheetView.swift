//
//  ProfileEditorSheetView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct ProfileEditorSheetView: View {

  enum SwipeActionButtons {
    case edit, delete

    var displayTitle: String {
      switch self {
      case .edit:
        "Edit"
      case .delete:
        "Delete Row"
      }
    }

    var systemImage: String {
      switch self {
      case .edit:
        "pencil"
      case .delete:
        "trash.fill"
      }
    }

    var tint: Color {
      switch self {
      case .edit:
          .blue
      case .delete:
          .red
      }
    }
  }

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

              /* CLEAN THIS UP
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
              */
            }
          }
          Section("Section Arrangement") {
            ForEach(sectionData) { section in
              ProfileEditorViewSectionCell(
                title: section.title,
                description: section.description,
                media: section.media
              )
              .onTapGesture {
                router.navigate(to: .sectionInfoEditor(sectionData: section) {
                  updateSectionWith(id: section.id, newSection: $0)
                })
              }
              .swipeActions(allowsFullSwipe: true) {
                if sectionData.count > 1 {
                  crateSwipeActionButton(swipeAction: .delete) {
                    sectionData.removeAll { $0.id == section.id }
                  }
                }
                crateSwipeActionButton(swipeAction: .edit) {
                  router.navigate(to: .sectionInfoEditor(sectionData: section) {
                    updateSectionWith(id: section.id, newSection: $0)
                  })
                }
              }
            }
            .onMove(perform: moveRow)

            createNewSectionRow

            /* CLEAN THIS UP
            if initialProfileDataViewInfo.sectionData != sectionData {
              Button {
                sectionData = initialProfileDataViewInfo.sectionData
              } label: {
                Text("Discard Changes")
                  .contentShape(Rectangle())
                  .foregroundStyle(.blue)
              }
              //            .listRowSeparator(.hidden)
              .buttonStyle(.bordered)
              .frame(maxWidth: .infinity, alignment: .center)
            }
            */

            Text("Drag to re-arrange sections.")
              .font(.footnote)
              .frame(maxWidth: .infinity)
              .listRowBackground(Color.clear)
              .opacity(0.5)
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

  private var createNewSectionRow: some View {
    Button {
      createNewSection()
    } label: {
      Text("Add New section \(Image(systemName: "plus"))")
        .font(.subheadline)
        .foregroundStyle(.gray.opacity(0.5))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .buttonStyle(.plain)
  }

  private func crateSwipeActionButton(swipeAction: SwipeActionButtons, action: @escaping (()->Void)) -> some View {
    Button(role: .destructive) {
      action()
    } label: {
      Label(swipeAction.displayTitle, systemImage: swipeAction.systemImage)
    }
    .tint(swipeAction.tint)
  }

  private func createNewSection() {
    router.navigate(
      to: .sectionInfoEditor(
        sectionData: SectionData()
      ) { newSection in
        sectionData.append(newSection)
        updateSectionWith(id: newSection.id, newSection: newSection)
      })
  }

  private func moveRow(source: IndexSet, destination: Int) {
    sectionData.move(fromOffsets: source, toOffset: destination)
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
