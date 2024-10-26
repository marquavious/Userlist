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
  @State var profile: Profile

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Section {
          ToggleStateControlPanel(
            title: "Show Updates",
            showChanges: $showProfileChanges
          )
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
  }
}

#Preview {
  ProfileEditorSheetViewForPreviews()
}
