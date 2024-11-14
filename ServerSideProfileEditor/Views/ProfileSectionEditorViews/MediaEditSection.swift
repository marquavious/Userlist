//
//  MediaEditSection.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import SwiftUI

struct MediaEditSection: View {

  @Binding var media: Media?

  var body: some View {
    Section("Media Edit") {
      if let unwrappedMedia = media {
        VStack {
          CreateMediaView(media: unwrappedMedia) { newMedia in
            media = newMedia
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
        AddMediaButton { newMedia in
          media = newMedia
        }
      }
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