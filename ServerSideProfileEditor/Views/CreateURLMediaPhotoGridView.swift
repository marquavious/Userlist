//
//  CreateURLMediaPhotoGridView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct CreateURLMediaPhotoGridView: View {
  var photoDataOne: PhotoData
  var photoDataTwo: PhotoData
  var photoDataThree: PhotoData
  var photoDataFour: PhotoData

  var didUpdateMedia: ((PhotoData,PhotoData,PhotoData,PhotoData) -> Void)

  var body: some View {
    VStack {
      CreateURLMediaPhotoView(
        url: photoDataOne.urlString ?? "",
        contentMode: CreateURLMediaPhotoView.ContentModeOption.optionMode(contentMode: photoDataOne.contentMode)
      ) { updatededPhotoDataOne in
        didUpdateMedia(p1: updatededPhotoDataOne)
      }
      CreateURLMediaPhotoView(
        url: photoDataTwo.urlString ?? "",
        contentMode: CreateURLMediaPhotoView.ContentModeOption.optionMode(contentMode: photoDataTwo.contentMode)
      ) { updatededPhotoDataTwo in
        didUpdateMedia(p2: updatededPhotoDataTwo)
      }
      CreateURLMediaPhotoView(
        url: photoDataThree.urlString ?? "",
        contentMode: CreateURLMediaPhotoView.ContentModeOption.optionMode(contentMode: photoDataThree.contentMode)
      ) { updatededPhotoDataThree in
        didUpdateMedia(p3: updatededPhotoDataThree)
      }
      CreateURLMediaPhotoView(
        url: photoDataFour.urlString ?? "",
        contentMode: CreateURLMediaPhotoView.ContentModeOption.optionMode(contentMode: photoDataFour.contentMode)
      ) { updatededPhotoDataFour in
        didUpdateMedia(p4: updatededPhotoDataFour)
      }
    }
  }

  private func didUpdateMedia(
    p1: PhotoData? = nil,
    p2: PhotoData? = nil,
    p3: PhotoData? = nil,
    p4: PhotoData? = nil
  ) {
    didUpdateMedia(
      p1 ?? photoDataOne
      ,p2 ?? photoDataTwo
      ,p3 ?? photoDataThree
      ,p4 ?? photoDataFour
    )
  }
}
