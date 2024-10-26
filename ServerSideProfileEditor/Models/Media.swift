//
//  Media.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation
import SwiftUI

enum Media: Equatable, CaseIterable {
  // Only for type checking,
  // There is for sure a better way to do this..
  static var allCases: [Media] = [
    .urlPhoto(photoData: PhotoData.emptyInstance()),
    .urlPhotoCarousel(photoArray: [PhotoData.emptyInstance(), PhotoData.emptyInstance(), PhotoData.emptyInstance()]),
    .urlPhotoGrid(photoDataOne: PhotoData.emptyInstance(), photoDataTwo: PhotoData.emptyInstance(), photoDataThree: PhotoData.emptyInstance(), photoDataFour: PhotoData.emptyInstance())
  ]
  case urlPhoto(
    photoData: PhotoData
  )
  case urlPhotoGrid(
    photoDataOne: PhotoData,
    photoDataTwo: PhotoData,
    photoDataThree: PhotoData,
    photoDataFour: PhotoData
  )
  case urlPhotoCarousel(
    photoArray: [PhotoData]
  )
  var description: String {
    switch self {
    case .urlPhoto:
      "Photo"
    case .urlPhotoGrid:
      "Photo Grid"
    case .urlPhotoCarousel:
      "Photo Carousel"
    }
  }
}

extension Media {
  static func generateRandomMedia() -> Media {
    let mediaType =
    // Media.urlPhotoCarousel(photoArray: [PhotoData.emptyInstance()])
    allCases.randomElement()!
    switch mediaType {
    case .urlPhoto:
      return Media.urlPhoto(
        photoData: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!)
      )
    case .urlPhotoGrid:
      return Media.urlPhotoGrid(
        photoDataOne: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataTwo: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataThree: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataFour: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        )
      )
    case .urlPhotoCarousel:
      return .urlPhotoCarousel(photoArray: [
        .init(id: UUID().uuidString, urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!),
        .init(id: UUID().uuidString, urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!),
        .init(id: UUID().uuidString, urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!)
      ])
    }
  }
}
