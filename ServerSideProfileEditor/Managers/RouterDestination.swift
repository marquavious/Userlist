//
//  RouterDestination.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation

typealias UpdatedSectionClosure = (SectionData) -> Void

enum RouterDestination: Identifiable, Hashable {
  static func == (lhs: RouterDestination, rhs: RouterDestination) -> Bool {
    lhs.id == rhs.id
  }
  
  case profile(id: String)
  case userInfoEditor(profile: Profile)
  case sectionInfoEditor(section: SectionData, updatedSectionClosure: UpdatedSectionClosure)

  var id: String {
    switch self {
    case .profile(let id):
      "profile_\(id)"
    case .userInfoEditor(let profile):
      "profile_editor_\(profile.id)"
    case .sectionInfoEditor(let section, _):
      "section_editor_\(section.id)"
    }
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
