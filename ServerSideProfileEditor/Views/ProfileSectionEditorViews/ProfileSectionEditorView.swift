//
//  ProfileSectionEditorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import SwiftUI

struct ProfileSectionEditorView: View {

  enum EditorFocus: Hashable {
    case title, description, media
  }

  @State var titleText: String = ""
  @State var descriptionText: String = ""
  @State var alignment: SectionData.Alignment = .leading
  @State var layout: SectionData.Layout = .top
  @State var media: Media?
  @FocusState private var editorFocus: EditorFocus?
  @State var showChanges: Bool = true
  @State var updatedState: ProfileSectionEditorViewState

  private var initialState: ProfileSectionEditorViewState
  private var sectionDidUpdate: UpdatedSectionClosure

  init(sectionData: SectionData, sectionDidUpdate: @escaping UpdatedSectionClosure) {
    self.sectionDidUpdate = sectionDidUpdate
    self.initialState = .init(sectionData: sectionData)
    self.updatedState = .init(sectionData: sectionData)
  }

  var body: some View {
    List {
      Section("Preview") {
        SectionView(
          title: titleText,
          description: descriptionText,
          media: media,
          alignment: alignment,
          mediaPosition: layout
        )
        .padding(.vertical, 8)
      }

      ControlPanelSection(
        showChanges: $showChanges
      ) {
        saveButtonPressed()
      } discardButtonPressed: {
        discardButtonPressed()
      }

      EditorLayoutSection(
        alignment: $alignment,
        layout: $layout,
        media: $media
      )
      .disabled(media == nil && (titleText.isEmpty || descriptionText.isEmpty))
      .disabled(titleText.isEmpty && descriptionText.isEmpty)

      TextEditSection(
        titleText: $titleText,
        descriptionText: $descriptionText,
        editorFocus: $editorFocus
      )

      MediaEditSection(media: $media)
    }
    .onAppear {
      refreshView()
    }
    .onChange(of: titleText) { _, newValue in
      if showChanges {
        updatedState.titleText = newValue
        refreshView()
      }
    }
    .onChange(of: descriptionText) { _, newValue in
      if showChanges {
        updatedState.descriptionText = newValue
        refreshView()
      }
    }
    .onChange(of: media) { _, newValue in
      if showChanges {
        updatedState.media = newValue
        refreshView()
      }
    }
    .onChange(of: alignment) { _, newValue in
      if showChanges {
        updatedState.alignment = newValue
        refreshView()
      }
    }
    .onChange(of: layout) { _, newValue in
      if showChanges {
        updatedState.layout = newValue
        refreshView()
      }
    }
    .onChange(of: showChanges) { _, newValue in
      refreshView()
    }
  }

  private func saveButtonPressed() {
    sectionDidUpdate(
      SectionData(
        index: updatedState.index,
        title: updatedState.titleText,
        description: updatedState.descriptionText,
        layout: updatedState.layout,
        alignment: updatedState.alignment,
        media: updatedState.media
      )
    )
  }

  private func discardButtonPressed() {
    updatedState.copyState(initialState)
    refreshView()
  }

  private func refreshView() {
    if showChanges {
      titleText = updatedState.titleText ?? ""
      descriptionText = updatedState.descriptionText ?? ""
      media = updatedState.media
      alignment = updatedState.alignment
      layout = updatedState.layout
    } else {
      titleText = initialState.titleText ?? ""
      descriptionText = initialState.descriptionText ?? ""
      media = initialState.media
      alignment = initialState.alignment
      layout = initialState.layout
    }
  }
}

#Preview {
  ProfileSectionEditorViewForPreview(
    media:
        .urlPhoto(
          photoData:
            PhotoData(
              id: UUID().uuidString,
              urlString: "https://i.imgur.com/ApCOa7j.jpeg",
              contentMode: .allCases.randomElement()!
            )
        )
  )
}
