//
//  Profile.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

struct Profile: Identifiable {
  let id: String
  var userInfo: User
  var sections: [SectionData]
}

extension Profile: Hashable, Equatable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: Profile, rhs: Profile) -> Bool {
    lhs.id == rhs.id &&
    lhs.userInfo == rhs.userInfo &&
    lhs.sections == rhs.sections
  }
}
