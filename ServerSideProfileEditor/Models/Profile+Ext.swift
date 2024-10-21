//
//  Profile+Ext.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

extension Profile {
  static func generatRandomProfile(id: String? = nil) -> Profile {
    .init(
      id: id ?? UUID().uuidString,
      userInfo: User(
        username: ProfileStubGenerator.randomUsername(),
        description: ProfileStubGenerator.randomText(),
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
  }
}
