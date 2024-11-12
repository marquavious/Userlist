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
    var alignment: SectionData.Alignment
    var mediaPosition: SectionData.MediaPosition

    init(
      id: String,
      index: Int,
      titleText: String?,
      descriptionText: String?,
      alignment: SectionData.Alignment,
      media: Media?,
      mediaPosition: SectionData.MediaPosition
    ) {
      self.id = id
      self.index = index
      self.titleText = titleText
      self.descriptionText = descriptionText
      self.alignment = alignment
      self.media = media
      self.mediaPosition = mediaPosition
    }

    func copyState(_ state: ProfileSectionEditorViewInfo) {
      self.id = state.id
      self.index = state.index
      self.titleText = state.titleText
      self.descriptionText = state.descriptionText
      self.media = state.media
    }
  }

  @State var titleText: String = ""
  @State var descriptionText: String = ""
  @State var alignment: SectionData.Alignment = .leading
  @State var mediaPosition: SectionData.MediaPosition = .top
  @State var media: Media?
  @FocusState private var formFocus: FormFocus?
  @State var sheetPresentationDetent: PresentationDetent = PresentationDetent.fraction(0.2)
  @State var showChanges: Bool = true
  @State var updatedState: ProfileSectionEditorViewInfo

  var initialState: ProfileSectionEditorViewInfo
  var sectionDidUpdate: UpdatedSectionClosure

  init(
    id: String,
    index: Int,
    titleText: String = "",
    descriptionText: String = "",
    alignment: SectionData.Alignment,
    media: Media?,
    mediaPosition: SectionData.MediaPosition,
    sectionDidUpdate: @escaping UpdatedSectionClosure
  ) {
    self.sectionDidUpdate = sectionDidUpdate
    let stateData = ProfileSectionEditorViewInfo(
      id: id,
      index: index,
      titleText: titleText,
      descriptionText: descriptionText,
      alignment: alignment,
      media: media,
      mediaPosition: mediaPosition
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
      alignment: sectionData.alignment,
      media: sectionData.media,
      mediaPosition: sectionData.mediaPosition
    )
    self.updatedState = ProfileSectionEditorViewInfo(
      id: sectionData.id,
      index: sectionData.index,
      titleText: sectionData.title,
      descriptionText: sectionData.description,
      alignment: sectionData.alignment,
      media: sectionData.media,
      mediaPosition: sectionData.mediaPosition
    )
  }

  var body: some View {
    List {
      Section("Preview") {
        SectionView(
          title: titleText,
          description: descriptionText,
          media: media,
          alignment: alignment,
          mediaPosition: mediaPosition
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
              alignment: updatedState.alignment,
              media: updatedState.media
            )
          )
        } discardChangesPressed: {
          updatedState.copyState(initialState)
          refreshData()
        }
        .padding(.vertical, 8)
      }

      Section("Layout") {
        VStack {
          Picker("Text Position", selection: $alignment) {
            ForEach(SectionData.Alignment.allCases) { option in
              Image(systemName: option.systemImageString)
                .tag(option)
                .tint(.blue)
            }
          }
          .pickerStyle(.segmented)

          Picker("Media Position", selection: $mediaPosition) {
            ForEach(SectionData.MediaPosition.allCases) { option in
              Image(systemName: option.systemImageString)
                .tag(option)
                .tint(.blue)
            }
          }
          .pickerStyle(.segmented)
        }
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
          VStack {
            CreateMediaView(media: unwrappedMedia) { newMedia in
              self.media = newMedia
            }
            Button {
              media = nil
            } label: {
              Text("Delete Media")
                .contentShape(Rectangle())
            }
            .buttonStyle(.bordered)
          }
          .padding(.top, 8)
        } else {
          Menu("Add Media +", systemImage: "photo") {
            Button("Photo With URL") {
              withAnimation(.easeInOut(duration: 0.2)) {
                self.media = .urlPhoto(photoData: .emptyInstance())
              }
            }

            Button("Photo Grid With URLs") {
              withAnimation(.easeInOut(duration: 0.2)) {
                self.media = .urlPhotoGrid(
                  photoDataOne: .emptyInstance(),
                  photoDataTwo: .emptyInstance(),
                  photoDataThree: .emptyInstance(),
                  photoDataFour: .emptyInstance()
                )
              }
            }

            Button("Photo Carusel With URLs") {
              self.media = .urlPhotoCarousel(photoArray: [.emptyInstance()])
            }
          }.menuStyle(.borderlessButton)
        }
      }
    }
    .onAppear {
      refreshData()
    }
    .onChange(of: titleText) { oldValue, newValue in
      if showChanges {
        updatedState.titleText = newValue
        refreshData()
      }
    }
    .onChange(of: descriptionText) { oldValue, newValue in
      if showChanges {
        updatedState.descriptionText = newValue
        refreshData()
      }
    }
    .onChange(of: media) { oldValue, newValue in
      if showChanges {
        updatedState.media = newValue
        refreshData()
      }
    }
    .onChange(of: alignment) { oldValue, newValue in
      if showChanges {
        updatedState.alignment = newValue
        refreshData()
      }
    }
    .onChange(of: mediaPosition) { oldValue, newValue in
      if showChanges {
        updatedState.mediaPosition = newValue
        refreshData()
      }
    }
    .onChange(of: showChanges) { oldValue, newValue in
      refreshData()
    }
  }

  private func refreshData() {
    if showChanges {
      titleText = updatedState.titleText ?? ""
      descriptionText = updatedState.descriptionText ?? ""
      media = updatedState.media
      alignment = updatedState.alignment
      mediaPosition = updatedState.mediaPosition
    } else {
      titleText = initialState.titleText ?? ""
      descriptionText = initialState.descriptionText ?? ""
      media = initialState.media
      alignment = initialState.alignment
      mediaPosition = initialState.mediaPosition
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
