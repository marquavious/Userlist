//
//  Media.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

enum Media: Equatable {
  case urlPhoto(String?)
  case urlPhotoGrid(String?,String?,String?,String?)

  var description: String {
    switch self {
    case .urlPhoto:
      "Photo"
    case .urlPhotoGrid:
      "Photo Grid"
    }
  }
}
