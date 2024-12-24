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
        /* C'mon Apple. You're worth how much? 3T??? there must be a way to do this...
        ForEach(ProfileSectionEditorView.EditorFocus.textOnlyCases) { textField in
          CustomTextField(
            title: textField.title,
            textfieldPrompt: textField.prompt,
            isRequired: textField.isRequired,
            text: createBindingFor(editorFocus: textField)
          )
          .environment(\.isFocused, editorFocus == textField)
          .focused($editorFocus, equals: textField)
        }
        */

        // Sigh...
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
    }
  }

  private func createBindingFor(editorFocus: ProfileSectionEditorView.EditorFocus) -> Binding<String> {
    switch editorFocus {
    case .title:
      $titleText
    case .description:
      $descriptionText
    case .media:
      fatalError("Use Media Section")
    }
  }
}

#Preview {
  ProfileSectionEditorViewForPreviews(
    media:
        .urlPhoto(
          photoData: PhotoData(
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          )
        )
  )
}
