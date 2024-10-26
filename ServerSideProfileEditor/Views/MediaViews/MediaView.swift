//
//  MediaView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct MediaView: View {

  var media: Media
  @State var cornerRadius: CGFloat

  var body: some View {
    switch media {
    case .urlPhoto(let photoData):
      CustomContentModeImageView(urlString: photoData.urlString, contentMode: photoData.contentMode)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    case .urlPhotoGrid(let photoDataOne, let photoDataTwo, let photoDataThree, let photoDataFour):
      PhotoGridView(
        cornerRadius: cornerRadius,
        photoDataOne: photoDataOne,
        photoDataTwo: photoDataTwo,
        photoDataThree: photoDataThree,
        photoDataFour: photoDataFour
      )
    case .urlPhotoCarousel(photoArray: let photoArray):
      PhotoCarouselView(
        photoArray: photoArray,
        photoCornerRadius: Theme.Geomitry.cornerRadius.radius
      )
    }
  }
}
