//
//  ProfileSectionEditorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import SwiftUI

struct ProfileSectionEditorView: View {

  private enum FormFocus: Hashable {
    case title, description, media

    var displayTitle: String {
      switch self {
      case .title:
        "Title"
      case .description:
        "Description"
      case .media:
        "Media"
      }
    }

    var prompt: String {
      switch self {
      case .title:
        "Title..."
      case .description:
        "Description..."
      case .media:
        "Media..."
      }
    }
  }

  @State var sectionData: SectionData
  var sectionDidUpdate: UpdatedSectionClosure
  @FocusState private var formFocus: FormFocus?
  @State var titleText: String = ""
  @State private var descriptionText: String = ""
  @State var sheetPresentationDetent: PresentationDetent = PresentationDetent.fraction(0.2)
  @State var showChanges: Bool = true

  var body: some View {
    List {
      Section("Preview") {
        SectionView(
          title: sectionData.title,
          description: sectionData.description,
          media: sectionData.media,
          horizontalAlignment: sectionData.alignment.horizontalAlignment
        )
        .padding(.vertical, 8)
      }

      Section("Control Panel") {
        ToggleStateControlPanel(
          title: "Show Updates",
          showChanges: $showChanges
        )
        .padding(.vertical, 8)
      }

      Section("Text Edit") {
        VStack {
          CustomTextField(
            title: "Title",
            textfieldPrompt: "Title...",
            isRequired: false,
            text: $titleText
          )
          .environment(\.isFocused, formFocus == .title)
          .focused($formFocus, equals: .title)
          CustomTextField(
            title: "Description",
            textfieldPrompt: "Description...",
            isRequired: false,
            text: $descriptionText
          )
          .environment(\.isFocused, formFocus == .description)
          .focused($formFocus, equals: .description)
        }
        .padding(.vertical, 8)
      }
    }
  }
}

#Preview {
  ProfileSectionEditorViewForPreview()
}
