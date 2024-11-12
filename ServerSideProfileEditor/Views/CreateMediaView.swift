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
        url: photoData.urlString ?? "",
        contentMode: CreateURLMediaPhotoView.ContentModeOption.optionMode(contentMode: photoData.contentMode)
      ) {
        createdMedia(.urlPhoto(photoData: $0))
      }
    case .urlPhotoGrid(let photoDataOne, let photoDataTwo, let photoDataThree, let photoDataFour):
      CreateURLMediaPhotoGridView(
        photoDataOne: photoDataOne,
        photoDataTwo: photoDataTwo,
        photoDataThree: photoDataThree,
        photoDataFour: photoDataFour
      ){
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
        createdMedia(
          .urlPhotoCarousel(photoArray: $0)
        )
      }
    }
  }
}
