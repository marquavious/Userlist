//
//  CreateURLMediaPhotoCarouselView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/1/24.
//

import Foundation
import SwiftUI

struct CreateURLMediaPhotoCarouselView: View {

  @State private var arrayOfPhotoData: [PhotoData]
  var didUpdateMedia: (([PhotoData]) -> Void)

  init(photoArray: [PhotoData], didUpdateMedia: @escaping ([PhotoData]) -> Void) {
    self.arrayOfPhotoData = photoArray
    self.didUpdateMedia = didUpdateMedia
  }

  var body: some View {
    VStack(spacing: 8) {
      ForEach(Array(arrayOfPhotoData.enumerated()), id: \.offset) { index, data in
        CreateURLMediaTextFieldView(
          url: Binding<String>(get: { arrayOfPhotoData[index].urlString ?? "" }, set: { arrayOfPhotoData[index].urlString = $0 }),
          contentMode: CreateURLMediaTextFieldView.ContentModeOption.optionFor(contentMode: data.contentMode),
          externalOptions: [
            (id: "autofill", systemImageString: "dice", tint: .blue, action: { autoFill(index: index, oldPhotoData: data) }),
            (id: "move_up", systemImageString: "chevron.up", tint: .green, action: { moveElementUp(&arrayOfPhotoData, at: index) }),
            (id: "move_down", systemImageString: "chevron.down", tint: .green, action: { moveElementDown(&arrayOfPhotoData, at: index) }),
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
    }
  }

  private func moveElementUp(_ array: inout [PhotoData], at index: Int) {
    guard index > 0 else { return }
    array.swapAt(index, index - 1)
    didUpdateMedia(self.arrayOfPhotoData)
  }

  private func moveElementDown(_ array: inout [PhotoData], at index: Int) {
    guard index < array.count - 1 else { return }
    array.swapAt(index, index + 1)
    didUpdateMedia(self.arrayOfPhotoData)
  }

  private func autoFill(index: Int, oldPhotoData: PhotoData) {
    updateMedia(index: index, photoData: .init(
      urlString: ProfileStubGenerator.randomMediaPicture(),
      contentMode: oldPhotoData.contentMode
    ))
    didUpdateMedia(self.arrayOfPhotoData)
  }

  private func removeAt(index: Int) {
    arrayOfPhotoData.remove(at: index)
    didUpdateMedia(self.arrayOfPhotoData)
  }

  private func addOne(photoData: PhotoData) {
    self.arrayOfPhotoData.append(photoData)
    didUpdateMedia(self.arrayOfPhotoData)
  }

  private func updateMedia(index: Int, photoData: PhotoData) {
    self.arrayOfPhotoData[index] = photoData
    didUpdateMedia(self.arrayOfPhotoData)
  }
}

#Preview {
  CreateURLMediaPhotoCarouselView(photoArray: [PhotoData.emptyInstance()]) { _ in

  }
}
