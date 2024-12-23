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
      if let media {
        VStack {
          CreateMediaView(media: media)
          { newMedia in
            self.media = newMedia
          }

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
            id: UUID().uuidString,
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          )
        )
  )
}
