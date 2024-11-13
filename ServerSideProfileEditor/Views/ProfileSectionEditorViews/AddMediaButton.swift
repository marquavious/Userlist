//
//  AddMediaButton.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import SwiftUI

struct AddMediaButton: View {

  var didSelectMediaOption: ((Media) -> Void)
  var body: some View {
    Menu("Add Media +", systemImage: "photo") {
      Button("Photo With URL") {
        withAnimation(.easeInOut(duration: 0.2)) {
          didSelectMediaOption(.urlPhoto(photoData: .emptyInstance()))
        }
      }

      Button("Photo Grid With URLs") {
        withAnimation(.easeInOut(duration: 0.2)) {
          didSelectMediaOption(.urlPhotoGrid(
            photoDataOne: .emptyInstance(),
            photoDataTwo: .emptyInstance(),
            photoDataThree: .emptyInstance(),
            photoDataFour: .emptyInstance()
          ))
        }
      }

      Button("Photo Carusel With URLs") {
        didSelectMediaOption(.urlPhotoCarousel(photoArray: [.emptyInstance()]))
      }
    }.menuStyle(.borderlessButton)
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
