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
    case .urlPhoto(var photoData):
      // Extract View
      CreateURLMediaPhotoView(
        url: Binding<String>(get: { photoData.urlString ?? "" }, set: { photoData.urlString = $0 }),
        contentMode: CreateURLMediaPhotoView.ContentModeOption.optionFor(contentMode: photoData.contentMode)
      ) {
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
    }
  }
}
