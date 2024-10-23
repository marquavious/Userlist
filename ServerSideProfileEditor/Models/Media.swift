//
//  Media.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation
import SwiftUI

enum Media: Equatable {
  case urlPhoto(
    photoData: PhotoData
  )
  case urlPhotoGrid(
    photoDataOne: PhotoData,
    photoDataTwo: PhotoData,
    photoDataThree: PhotoData,
    photoDataFour: PhotoData
  )
  var description: String {
    switch self {
    case .urlPhoto:
      "Photo"
    case .urlPhotoGrid:
      "Photo Grid"
    }
  }
}

extension Media {
  static func generateRandomMedia() -> Media {
    if Bool.random() {
      return .urlPhoto(
        photoData: .init(
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!)
      )
    } else {
      return .urlPhotoGrid(
        photoDataOne: .init(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!),
        photoDataTwo: .init(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!),
        photoDataThree: .init(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!),
        photoDataFour: .init(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!)
      )
    }
  }
}

struct PhotoData: Equatable {
  let urlString: String?
  let contentMode: ContentMode
}
