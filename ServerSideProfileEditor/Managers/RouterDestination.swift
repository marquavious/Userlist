//
//  RouterDestination.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation

enum RouterDestination: Identifiable, Hashable {
  case profile(id: String)

  var plaintextDescription: String {
    switch self {
    case .profile:
      "profile"
    }
  }
  
  var id: String {
    switch self {
    case .profile(let id):
      "profile_\(id)"
    }
  }
}
