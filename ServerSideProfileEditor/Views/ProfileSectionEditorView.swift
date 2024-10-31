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

  class ProfileSectionEditorViewInfo {
    var id: String
    var index: Int
    var titleText: String?
    var descriptionText: String?
    var media: Media?

    init(
      id: String,
      index: Int,
      titleText: String?,
      descriptionText: String?,
      media: Media?
    ) {
      self.id = id
      self.index = index
      self.titleText = titleText
      self.descriptionText = descriptionText
      self.media = media
    }
  }

  @State var titleText: String = ""
  @State var descriptionText: String = ""
  @State var media: Media?
  @FocusState private var formFocus: FormFocus?
  @State var sheetPresentationDetent: PresentationDetent = PresentationDetent.fraction(0.2)
  @State var showChanges: Bool = true

  @State var initialState: ProfileSectionEditorViewInfo
  @State var updatedState: ProfileSectionEditorViewInfo

  var sectionDidUpdate: UpdatedSectionClosure

  init(
  id: String,
  index: Int,
  titleText: String = "",
  descriptionText: String = "",
  media: Media?,
  sectionDidUpdate: @escaping UpdatedSectionClosure
  ) {
    self.sectionDidUpdate = sectionDidUpdate
    let stateData = ProfileSectionEditorViewInfo(
      id: id,
      index: index,
      titleText: titleText,
      descriptionText: descriptionText,
      media: media
    )
    self.initialState = stateData
    self.updatedState = stateData
  }

  init(sectionData: SectionData, sectionDidUpdate: @escaping UpdatedSectionClosure) {
    self.sectionDidUpdate = sectionDidUpdate

    self.initialState = ProfileSectionEditorViewInfo(
      id: sectionData.id,
      index: sectionData.index,
      titleText: sectionData.title,
      descriptionText: sectionData.description,
      media: sectionData.media
    )
    self.updatedState = ProfileSectionEditorViewInfo(
      id: sectionData.id,
      index: sectionData.index,
      titleText: sectionData.title,
      descriptionText: sectionData.description,
      media: sectionData.media
    )
  }

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
          sectionDidUpdate(
            SectionData(
              index: updatedState.index,
              title: updatedState.titleText,
              description: updatedState.descriptionText,
              media: updatedState.media
            )
          )
        } discardChangesPressed:  {
          
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
      titleText = updatedState.titleText ?? ""
      descriptionText = updatedState.descriptionText ?? ""
      media = updatedState.media
      refreshTextFields()
    }
    .onChange(of: titleText) { oldValue, newValue in
      if showChanges {
        updatedState.titleText = newValue
      }
      refreshTextFields()
    }
    .onChange(of: descriptionText) { oldValue, newValue in
      if showChanges {
        updatedState.descriptionText = newValue
      }
      refreshTextFields()
    }
    .onChange(of: media) { oldValue, newValue in
      if showChanges {
        updatedState.media = newValue
      }
      refreshTextFields()
    }
    .onChange(of: showChanges) { oldValue, newValue in
      refreshTextFields()
    }
  }

  private func refreshTextFields() {
    if showChanges {
      titleText = updatedState.titleText ?? ""
      descriptionText = updatedState.descriptionText ?? ""
      media = updatedState.media
    } else {
      titleText = initialState.titleText ?? ""
      descriptionText = initialState.descriptionText ?? ""
      media = initialState.media
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
