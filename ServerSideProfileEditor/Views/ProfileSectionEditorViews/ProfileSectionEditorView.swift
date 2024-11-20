//
//  ProfileSectionEditorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import SwiftUI

struct ProfileSectionEditorView: View {

  enum EditorFocus: Hashable, CaseIterable {
    case title, description, media
  }

  @State var titleText: String = ""
  @State var descriptionText: String = ""
  @State var alignment: SectionLayout.AlignmentGuide = .leading
  @State var layout: SectionLayout.Arrangement = .top
  @State var media: Media?
  @State var showChanges: Bool = true
  @State var updatedState: ProfileSectionEditorViewState
  
  @FocusState private var editorFocus: EditorFocus?
  private var initialState: ProfileSectionEditorViewState
  private var sectionDidUpdate: SectionDidUpdate

  init(sectionData: SectionData, sectionDidUpdate: @escaping SectionDidUpdate) {
    self.sectionDidUpdate = sectionDidUpdate
    self.initialState = .init(sectionData: sectionData)
    self.updatedState = .init(sectionData: sectionData)
  }

  var body: some View {
    List {
      Section("Preview") {
        SectionCell(
          title: titleText,
          description: descriptionText,
          media: media,
          alignment: alignment,
          mediaPosition: layout
        )
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
      .disabled(media == nil && (titleText.isEmpty && descriptionText.isEmpty))

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
    setState(state: showChanges ? updatedState : initialState)
  }

  private func setState(state: ProfileSectionEditorViewState) {
    titleText = state.titleText ?? ""
    descriptionText = state.descriptionText ?? ""
    media = state.media
    alignment = state.alignment
    layout = state.layout
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
