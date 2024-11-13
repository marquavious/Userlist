//
//  TextEditSection.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import SwiftUI

struct TextEditSection: View {

  @Binding var titleText: String
  @Binding var descriptionText: String
  @FocusState.Binding var editorFocus: ProfileSectionEditorView.EditorFocus?

  var body: some View {
    Section("Text Edit") {
      VStack {
        CustomTextField(
          title: "Title",
          textfieldPrompt: "Title...",
          isRequired: false,
          text: $titleText
        )
        .environment(\.isFocused, editorFocus == .title)
        .focused($editorFocus, equals: .title)
        CustomTextField(
          title: "Description",
          textfieldPrompt: "Description...",
          isRequired: false,
          text: $descriptionText
        )
        .environment(\.isFocused, editorFocus == .description)
        .focused($editorFocus, equals: .description)
      }
      .padding(.vertical, 8)
    }
  }
}

#Preview {
  ProfileSectionEditorViewForPreview(
    media:
        .urlPhoto(
          photoData: PhotoData(
            id: UUID().uuidString,
            urlString: "https://i.imgur.com/ApCOa7j.jpeg",
            contentMode: .allCases.randomElement()!
          )
        )
  )
}
