//
//  CreateURLMediaPhotoView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/12/24.
//

import SwiftUI

struct CreateURLMediaPhotoView: View {

  @State var photoData: PhotoData

  var didUpdateMedia: ((PhotoData) -> Void)

  var body: some View {
    CreateURLMediaTextFieldView(
      url: Binding<String>(get: { photoData.urlString ?? "" }, set: { photoData.urlString = $0 }),
      contentMode: CreateURLMediaTextFieldView.ContentModeOption.optionFor(contentMode: photoData.contentMode),
      externalOptions: [
        (id: "autofill", systemImageString: "dice", tint: .blue, action: { autoFill() })
      ]
    ) {
      didUpdateMedia($0)
    }
  }

  private func autoFill() {
    photoData =
      .init(
        urlString: ProfileStubGenerator.randomMediaPicture(),
        contentMode: photoData.contentMode
      )
  }
}

#Preview {
  CreateURLMediaPhotoView(photoData: .emptyInstance()) { _ in }
}
