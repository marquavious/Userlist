//
//  RouterDestination.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation

typealias SectionDidUpdate = (SectionData) -> Void
typealias UserDidUpdate = (UserData) -> Void

enum RouterDestination: Identifiable {

  case profile(id: String)
  case userInfoEditor(userData: UserData, userDidUpdate: UserDidUpdate)
  case sectionInfoEditor(sectionData: SectionData, sectionDidUpdate: SectionDidUpdate)

  var id: String {
    switch self {
    case .profile(let id):
      "profile_\(id)"
    case .userInfoEditor(let user, _):
      "user_editor_\(user.username)"
    case .sectionInfoEditor(let section, _):
      "section_editor_\(section.id)"
    }
  }
}

extension RouterDestination: Hashable {

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: RouterDestination, rhs: RouterDestination) -> Bool {
    lhs.id == rhs.id
  }
}
