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

extension Profile {

  static func emptyProfile() -> Profile {
    Profile(
      id: UUID().uuidString,
      userInfo: User(username: "", description: ""),
      sections: []
    )
  }

  static func generatRandomProfile(id: String? = nil) -> Profile {
    
    let userInfo = ProfileStubGenerator.randomUsernameDescriptionBundle()
    
    let profile = Profile(
      id: id ?? UUID().uuidString,
      userInfo: User(
        username: userInfo.username,
        description: userInfo.description,
        profilePictureUrlString: ProfileStubGenerator.randomProfilePicture(),
        profileHeaderUrlString: ProfileStubGenerator.randomBannerPicture()
      ),
      sections: [
        SectionData.stubs(index: 0),
        SectionData.stubs(index: 1),
        SectionData.stubs(index: 2),
        SectionData.stubs(index: 3)
      ]
    )
    
    return profile
  }
}
