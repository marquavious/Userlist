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
        CustomContentModePhotoView(
          url: URL(string: photoDataOne.urlString ?? ""),
          contentMode: photoDataOne.contentMode
        )
        CustomContentModePhotoView(
          url: URL(string: photoDataTwo.urlString  ?? ""),
          contentMode: photoDataTwo.contentMode
        )
      }
      HStack {
        CustomContentModePhotoView(
          url: URL(string: photoDataThree.urlString ?? ""),
          contentMode: photoDataThree.contentMode
        )
        CustomContentModePhotoView(
          url: URL(string: photoDataFour.urlString ?? ""),
          contentMode: photoDataFour.contentMode
        )
      }
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
