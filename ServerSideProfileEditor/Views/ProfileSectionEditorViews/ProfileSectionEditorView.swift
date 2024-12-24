//
//  ProfileSectionEditorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import SwiftUI

struct ProfileSectionEditorView: View {

  @Environment(\.dismiss) var dismiss

  enum EditorFocus: Hashable, CaseIterable, Identifiable {
    case title, description, media
    static let textOnlyCases: [Self] = [.title, .description]
    
    var id: String {
      UUID().uuidString
    }
    
    var title: String {
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
    
    var isRequired: Bool {
      false
    }
  }

  @State private var titleText: String = ""
  @State private var descriptionText: String = ""
  @State private var alignment: SectionLayout.AlignmentGuide = .leading
  @State private var layout: SectionLayout.Arrangement = .top
  @State private var media: Media?
  @State private var separator: Separator = .none
  @State private var showChanges: Bool = true
  @FocusState private var editorFocus: EditorFocus?
  @State private var updatedState: ProfileSectionEditorViewState
  @State private var initialState: ProfileSectionEditorViewState
  private var sectionDidUpdate: SectionDidUpdate

  init(sectionData: SectionData, sectionDidUpdate: @escaping SectionDidUpdate) {
    self.sectionDidUpdate = sectionDidUpdate
    self.initialState = .init(sectionData: sectionData)
    self.updatedState = .init(sectionData: sectionData)
  }

  private var changesExist: Bool {
    alignment != initialState.alignment ||
    layout != initialState.layout ||
    media != initialState.media ||
    separator != initialState.separator ||
    titleText != initialState.titleText ||
    descriptionText != initialState.descriptionText
  }

  var body: some View {
    List {
      Section("Preview") {
        VStack {
          SectionCell(
            title: titleText,
            description: descriptionText,
            media: media,
            alignment: alignment,
            mediaPosition: layout
          )
          SeparatorView(separator: separator)
        }
      }

      Section("Control Panel") {
        ToggleStateControlPanel(
          title: "Show Updates",
          showChanges: $showChanges,
          rightButtonText: changesExist ? "Discard Changes" : "Dismiss",
          leftButtonPressed: {
            saveButtonPressed()
          },
          rightButtonPressed: {
            if changesExist {
              discardButtonPressed()
            } else {
              dismiss()
            }
          }
        )
      }

      EditorLayoutSection(
        alignment: $alignment,
        layout: $layout,
        media: $media,
        separator: $separator
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
    .onChange(of: separator) { _, newValue in
      if showChanges {
        updatedState.separator = newValue
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
        media: updatedState.media,
        separator: updatedState.separator
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
    separator = state.separator
  }
}

#Preview {
  ProfileSectionEditorViewForPreviews(
    media:
        .urlPhoto(
          photoData:
            PhotoData(
              urlString: "https://i.imgur.com/ApCOa7j.jpeg",
              contentMode: .allCases.randomElement()!
            )
        )
  )
}
