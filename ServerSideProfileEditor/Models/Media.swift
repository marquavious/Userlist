//
//  Media.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation
import SwiftUI
import CoreLocation

enum Media: Equatable, CaseIterable, Identifiable {

  static var allCases: [Media] = [
    .urlPhoto(photoData: .emptyInstance()),
    .urlPhotoCarousel(photoArray: Array(repeating: .emptyInstance(), count: 4)),
    .urlPhotoGrid(photoDataOne: .emptyInstance(), photoDataTwo: .emptyInstance(), photoDataThree: .emptyInstance(), photoDataFour: .emptyInstance()),
    .location(title:"", latitude: 0, longitude: 0)
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

  case location(
    title: String,
    latitude: CLLocationDegrees,
    longitude: CLLocationDegrees
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
    case .location:
      "Map View"
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
    case .location:
      Media.location(
        title: "San Francicsco",
        latitude:  37.773972,
        longitude: -122.431297
      )
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
      return .urlPhotoGrid(
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
    case .location:
      return [
        Media.location(
          title: "New York",
          latitude: 40.730610, longitude: -73.935
        ),
        Media.location(
          title: "Seattle",
          latitude: 47.608013, longitude: -100.335
        ),
        Media.location(
          title: "San Francicsco",
          latitude: 37.733795, longitude: -100.446
        )
      ].randomElement()!
    }
  }
}

extension CLLocationCoordinate2D {
    static let newYork: Self = .init(
        latitude: 40.730610,
        longitude: -73.935
    )

    static let seattle: Self = .init(
        latitude: 47.608013,
        longitude: -100.335
    )

    static let sanFrancisco: Self = .init(
        latitude: 37.733795,
        longitude: -100.446
    )
}
