//
//  CreateURLMediaPhotoGridView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct CreateURLMediaPhotoGridView: View {
  @State var photoData: [PhotoData] = [
    .emptyInstance(),
    .emptyInstance(),
    .emptyInstance(),
    .emptyInstance()
  ]

  var didUpdateMedia: ((PhotoData, PhotoData, PhotoData, PhotoData) -> Void)

  var body: some View {
    VStack {
      ForEach(Array(photoData.enumerated()), id: \.offset) { index, data in
        CreateURLMediaTextFieldView(
          url: Binding<String>(get: { photoData[index].urlString ?? "" }, set: { photoData[index].urlString = $0 }),
          contentMode: CreateURLMediaTextFieldView.ContentModeOption.optionFor(contentMode: .fill),
          externalOptions: [
            (id: "autofill", systemImageString: "dice", tint: .blue, action: { autoFill(index: index, oldPhotoData: photoData[index]) }),
            (id: "move_up", systemImageString: "chevron.up", tint: .green, action: { moveElementUp(&photoData, at: index) }),
            (id: "move_down", systemImageString: "chevron.down", tint: .green, action: { moveElementDown(&photoData, at: index) }),
            (id: "delete", systemImageString: "trash", tint: .red, action: { removeAt(index: index)})
          ]
        ) { updateMedia(index: index, photoData: $0) }
      }
    }
  }

  private func moveElementUp(_ array: inout [PhotoData], at index: Int) {
    guard index > 0 else { return }
    array.swapAt(index, index - 1)
    updateMedia()
  }

  private func moveElementDown(_ array: inout [PhotoData], at index: Int) {
    guard index < array.count - 1 else { return }
    array.swapAt(index, index + 1)
    updateMedia()
  }

  private func autoFill(index: Int, oldPhotoData: PhotoData) {
    updateMedia(index: index, photoData: .init(
      urlString: ProfileStubGenerator.randomMediaPicture(),
      contentMode: oldPhotoData.contentMode
    ))
    updateMedia()
  }

  private func removeAt(index: Int) {
    photoData[index] = .emptyInstance()
    updateMedia()
  }

  private func addOne(photoData: PhotoData) {
    self.photoData.append(photoData)
    updateMedia()
  }

  private func updateMedia(index: Int, photoData: PhotoData) {
    self.photoData[index] = photoData
    updateMedia()
  }

  private func updateMedia() {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      didUpdateMedia(photoData[0], photoData[1], photoData[2], photoData[3])
    }
  }
}
