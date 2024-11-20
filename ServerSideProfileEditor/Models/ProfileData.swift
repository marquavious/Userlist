//
//  Profile.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

struct ProfileData: Identifiable {
  let id: String
  var user: UserData
  var sections: [SectionData]
}

extension ProfileData: Hashable, Equatable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: ProfileData, rhs: ProfileData) -> Bool {
    lhs.id == rhs.id &&
    lhs.user == rhs.user &&
    lhs.sections == rhs.sections
  }
}

extension ProfileData {
  static func emptyProfile() -> ProfileData {
    ProfileData(
      id: UUID().uuidString,
      user: UserData(username: "", description: ""),
      sections: []
    )
  }

  static func generatRandomProfile(id: String? = nil) -> ProfileData {
    let userInfo = ProfileStubGenerator.randomUsernameDescriptionBundle()

    let profile = ProfileData(
      id: id ?? UUID().uuidString,
      user: UserData(
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
