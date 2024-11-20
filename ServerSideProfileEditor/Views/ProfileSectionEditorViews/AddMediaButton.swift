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
          withAnimation(.easeInOut(duration: Double(Theme.AnimationSpeed.normal.rawValue))) {
            didSelectMedia(type.emptyInstance)
          }
        }
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
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          )
        )
  )
}
