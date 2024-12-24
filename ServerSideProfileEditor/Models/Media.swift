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
    .urlPhoto(
      photoData: .emptyInstance()
    ),
    .urlPhotoCarousel(
      photoArray: Array(repeating: .emptyInstance(), count: 4)
    ),
    .urlPhotoGrid(
      photoDataOne: .emptyInstance(),
      photoDataTwo: .emptyInstance(),
      photoDataThree: .emptyInstance(),
      photoDataFour: .emptyInstance()
    ),
    .mapView(
      title: "", latitude: 0, longitude: 0
    )
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

  case mapView(
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
    case .mapView:
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
    case .mapView:
      Media.mapView(
        title: "",
        latitude:  0,
        longitude: 0
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
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!)
      )
    case .urlPhotoGrid:
      return .urlPhotoGrid(
        photoDataOne: .init(
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataTwo: .init(
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataThree: .init(
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataFour: .init(
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        )
      )
    case .urlPhotoCarousel:
      return .urlPhotoCarousel(photoArray: [
        .init(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!),
        .init(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!),
        .init(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!)
      ])
    case .mapView:
      if case let .mapView(title, latitude, longitude) = ProfileStubGenerator.randomLocation() {
        return .mapView(title: title, latitude: latitude, longitude: longitude)
      } else {
        fatalError("Should never run")
      }
    }
  }
}
