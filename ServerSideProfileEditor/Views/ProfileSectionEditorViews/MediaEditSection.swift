//
//  MediaEditSection.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import SwiftUI

struct MediaEditSection: View {

  @Binding var media: Media?
  @FocusState.Binding var editorFocus: ProfileSectionEditorView.EditorFocus?

  var body: some View {
    Section("Media Edit") {
      if let media {
        VStack {
          CreateMediaView(media: media)
          { newMedia in
            self.media = newMedia
          }
          .environment(\.isFocused, editorFocus == .media)
          .focused($editorFocus, equals: .media)

          Button {
            self.media = .none
          } label: {
            Text("Delete Media")
              .contentShape(Rectangle())
          }
          .buttonStyle(.bordered)
        }
      } else {
        HStack {
          AddMediaButton { newMedia in
            self.media = newMedia
          }
          .frame(alignment: .center)
        }
      }
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
