//
//  PhotoGridView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct PhotoGridView: View {

  var photoDataOne: PhotoData
  var photoDataTwo: PhotoData
  var photoDataThree: PhotoData
  var photoDataFour: PhotoData

  var body: some View {
    VStack {
      HStack {
        CustomContentModePhotoView(photoData: photoDataOne)
        CustomContentModePhotoView(photoData: photoDataTwo)
      }
      HStack {
        CustomContentModePhotoView(photoData: photoDataThree)
        CustomContentModePhotoView(photoData: photoDataFour)
      }
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
