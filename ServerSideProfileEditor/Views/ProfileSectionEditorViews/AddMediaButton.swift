//
//  AddMediaButton.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import SwiftUI

struct AddMediaButton: View {

  var didSelectMedia: ((Media) -> Void)

  var body: some View {
    Menu("Add Media +", systemImage: "photo") {
      ForEach(Media.allCases) { type in
        Button(type.description) {
          withAnimation(.easeInOut(duration: Double(StyleConstants.AnimationSpeed.normal))) {
            didSelectMedia(type.emptyInstance)
          }
        }
      }
    }.menuStyle(.borderlessButton)
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
