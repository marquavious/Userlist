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

  var sectionData: SectionData
  @FocusState private var formFocus: FormFocus?
  @State var titleText: String = ""
  @State var descriptionText: String = ""
  @State var media: Media?
  @State var sheetPresentationDetent: PresentationDetent = PresentationDetent.fraction(0.2)
  @State var showChanges: Bool = true

  var sectionDidUpdate: UpdatedSectionClosure

  var body: some View {
    List {
      Section("Preview") {
        SectionView(
          title: titleText,
          description: descriptionText,
          media: media,
          horizontalAlignment: .leading
        )
        .padding(.vertical, 8)
      }
      Section("Control Panel") {
        ToggleStateControlPanel(
          title: "Show Updates",
          showChanges: $showChanges
        ) {
//          sectionDidUpdate(
//            User(
//              username: titleText,
//              description: descriptionText,
//              profilePictureUrlString: <#T##String#>,
//              profileHeaderUrlString: <#T##String#>
//            )
//          )
        }
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
      Section("Media Edit") {
        if let unwrappedMedia = media {
          CreateMediaView(media: unwrappedMedia) { newMedia in
            self.media = newMedia
          }
          .padding(.vertical, 8)
        }
      }
    }
    .onAppear {
      titleText = sectionData.title ?? ""
      descriptionText = sectionData.description ?? ""
      media = sectionData.media
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
            contentMode: .allCases.randomElement()!)
        )
  )
}
