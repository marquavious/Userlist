//
//  File.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct CreateMediaView: View {
  @State var media: Media

  var createdMedia: ((Media) -> Void)

  var body: some View {
    switch media {
    case .urlPhoto(let photoData):
      CreateURLMediaPhotoView(
        url: photoData.urlString ?? "",
        contentMode: CreateURLMediaPhotoView.ContentModeOption.optionMode(contentMode: photoData.contentMode)
      ) { photoData in
        createdMedia(.urlPhoto(photoData: photoData))
      }
    case .urlPhotoGrid:
      Rectangle()
        .fill(.blue)
    case .urlPhotoCarousel:
      Rectangle()
        .fill(.red)
    }
  }
}
