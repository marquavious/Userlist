//
//  File.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct CreateMediaView: View {

  var media: Media

  var createdMedia: ((Media) -> Void)

  var body: some View {
    switch media {
    case .urlPhoto(let photoData):
      CreateURLMediaPhotoView(
        photoData: photoData) {
          createdMedia(.urlPhoto(photoData: $0))
        }
    case .urlPhotoGrid(let photoDataOne, let photoDataTwo, let photoDataThree, let photoDataFour):
      CreateURLMediaPhotoGridView(photoData: [photoDataOne, photoDataTwo, photoDataThree, photoDataFour]){
        createdMedia(.urlPhotoGrid(
          photoDataOne: $0,
          photoDataTwo: $1,
          photoDataThree: $2,
          photoDataFour: $3
        ))
      }
    case .urlPhotoCarousel(let photos):
      CreateURLMediaPhotoCarouselView(
        photoArray: photos
      ){
        createdMedia(.urlPhotoCarousel(photoArray: $0))
      }
    case .mapView(title: let title, latitude: let latitude, longitude: let longitude):
      CreateMapMediaView(title: title, latitude: latitude, longitude: longitude) {
        createdMedia(.mapView(title: $0, latitude: $1, longitude: $2))
      }
    }
  }
}
