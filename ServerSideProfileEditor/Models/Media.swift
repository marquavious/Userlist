//
//  Media.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation
import SwiftUI

enum Media: Equatable, CaseIterable, Identifiable {

  static var allCases: [Media] = [
    .urlPhoto(photoData: .emptyInstance()),
    .urlPhotoCarousel(photoArray: Array(repeating: .emptyInstance(), count: 4)),
    .urlPhotoGrid(photoDataOne: .emptyInstance(), photoDataTwo: .emptyInstance(), photoDataThree: .emptyInstance(), photoDataFour: .emptyInstance())
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

  var id: String {
    UUID().uuidString
  }

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

  var emptyInstance: Self {
    switch self {
    case .urlPhoto:
        .urlPhoto(photoData: .emptyInstance())
    case .urlPhotoGrid:
        .urlPhotoGrid(
          photoDataOne: .emptyInstance(),
          photoDataTwo: .emptyInstance(),
          photoDataThree: .emptyInstance(),
          photoDataFour: .emptyInstance()
        )
    case .urlPhotoCarousel:
        .urlPhotoCarousel(photoArray: [.emptyInstance()])
    }
  }
}

extension Media {
  static func generateRandomMedia() -> Media {
    let mediaType = allCases.randomElement()!
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
