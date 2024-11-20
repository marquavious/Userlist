//
//  MediaView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct MediaWindowView: View {

  var media: Media

  var body: some View {
    switch media {
    case .urlPhoto(let photoData):
      CustomContentModePhotoView(
        url: URL(string: photoData.urlString ?? ""),
        contentMode: photoData.contentMode
      )
    case .urlPhotoGrid(
      let photoDataOne,
      let photoDataTwo,
      let photoDataThree,
      let photoDataFour):
      PhotoGridView(
        photoDataOne: photoDataOne,
        photoDataTwo: photoDataTwo,
        photoDataThree: photoDataThree,
        photoDataFour: photoDataFour
      )
    case .urlPhotoCarousel(photoArray: let photoArray):
      PhotoCarouselView(
        photoArray: photoArray
      )
    }
  }
}

#Preview {
  MediaWindowView(media: .generateRandomMedia())
    .frame(
      width: UIScreen.main.bounds.width - 16,
      height: Theme.MediaSizes.mediaHeight.height
    )
}
