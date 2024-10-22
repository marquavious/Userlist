//
//  Media.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

enum Media: Equatable {
  case urlPhoto(
    urlString: String?
  )
  case urlPhotoGrid(
    urlStringOne: String?,
    urlStringTwo: String?,
    urlStringThree: String?,
    urlStringFour: String?
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
      return .urlPhoto(urlString: ProfileStubGenerator.randomMediaPicture())
    } else {
      return .urlPhotoGrid(
        urlStringOne: ProfileStubGenerator.randomMediaPicture(),
        urlStringTwo: ProfileStubGenerator.randomMediaPicture(),
        urlStringThree: ProfileStubGenerator.randomMediaPicture(),
        urlStringFour:ProfileStubGenerator.randomMediaPicture()
      )
    }
  }
}
