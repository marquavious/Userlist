//
//  CreateURLMediaPhotoCarouselView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/1/24.
//

import Foundation
import SwiftUI

struct CreateURLMediaPhotoCarouselView: View {

  @State var photoData: [PhotoData]
  var didUpdateMedia: (([PhotoData]) -> Void)

  init(photoArray: [PhotoData], didUpdateMedia: @escaping ([PhotoData]) -> Void) {
    self.photoData = photoArray
    self.didUpdateMedia = didUpdateMedia
  }

  var body: some View {
    VStack(spacing: 8) {
      ForEach(Array(photoData.enumerated()), id: \.offset) { index, data in
        CreateURLMediaTextFieldView(
          url: Binding<String>(get: { photoData[index].urlString ?? "" }, set: { photoData[index].urlString = $0 }),
          contentMode: CreateURLMediaTextFieldView.ContentModeOption.optionFor(contentMode: data.contentMode),
          externalOptions: [
            (id: "autofill", systemImageString: "dice", tint: .blue, action: { autoFill(index: index, oldPhotoData: data) }),
            (id: "move_up", systemImageString: "chevron.up", tint: .green, action: { moveElementUp(&photoData, at: index) }),
            (id: "move_down", systemImageString: "chevron.down", tint: .green, action: { moveElementDown(&photoData, at: index) }),
            (id: "delete", systemImageString: "trash", tint: .red, action: { removeAt(index: index)})
          ]
        ) { updateMedia(index: index, photoData: $0) }
      }

      Button {
        addOne(photoData: .emptyInstance())
      } label: {
        Text("\(Image(systemName: "plus")) Add Image")
          .font(.subheadline)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .padding(.bottom, 4)
    }
  }

  func moveElementUp(_ array: inout [PhotoData], at index: Int) {
    guard index > 0 else { return }
    array.swapAt(index, index - 1)
    didUpdateMedia(self.photoData)
  }

  func moveElementDown(_ array: inout [PhotoData], at index: Int) {
    guard index < array.count - 1 else { return }
    array.swapAt(index, index + 1)

    didUpdateMedia(self.photoData)
  }

  func autoFill(index: Int, oldPhotoData: PhotoData) {
    updateMedia(index: index, photoData: .init(
      id: UUID().uuidString,
      urlString: ProfileStubGenerator.randomMediaPicture(),
      contentMode: oldPhotoData.contentMode
    ))
    didUpdateMedia(self.photoData)
  }

  func removeAt(index: Int) {
    photoData.remove(at: index)
    didUpdateMedia(self.photoData)
  }

  func addOne(photoData: PhotoData) {
    self.photoData.append(photoData)
    didUpdateMedia(self.photoData)
  }

  func updateMedia(index: Int, photoData: PhotoData) {
    self.photoData[index] = photoData
    didUpdateMedia(self.photoData)
  }
}

#Preview {
  CreateURLMediaPhotoCarouselView(photoArray: [PhotoData.emptyInstance()]) { _ in

  }
}
