//
//  MediaView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct MediaWindowView: View {

  var media: Media

  var body: some View {
    switch media {
    case .urlPhoto(let photoData):
      CustomContentModePhotoView(
        photoData: photoData
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
    case .mapView(title: let title, latitude: let latitude, longitude: let longitude):
      MapView(
        title: title,
        coordinate: .init(
          latitude: latitude,
          longitude: longitude
        )
      )
    }
  }
}

#Preview {
  MediaWindowView(media: .generateRandomMedia())
    .frame(
      width: UIScreen.main.bounds.width - 16,
      height: StyleConstants.MediaSizes.mediaHeight
    )
    .clipShape(RoundedRectangle(cornerRadius: StyleConstants.Geometry.cornerRadius))
}
