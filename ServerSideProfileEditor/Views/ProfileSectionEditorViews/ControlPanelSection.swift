//
//  ControlPanelSection.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import SwiftUI

struct ControlPanelSection: View {

  @Binding var showChanges: Bool

  var saveButtonPressed: (() -> Void)
  var discardButtonPressed: (() -> Void)

  var body: some View {
    Section("Control Panel") {
      ToggleStateControlPanel(
        title: "Show Updates",
        showChanges: $showChanges
      ) {
        saveButtonPressed()
      } discardChangesPressed: {
        discardButtonPressed()
      }
    }
  }
}

#Preview {
  ProfileSectionEditorViewForPreview(
    media:
        .urlPhoto(
          photoData: PhotoData(
            id: UUID().uuidString,
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          )
        )
  )
}
