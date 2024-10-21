//
//  User.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

struct User: Equatable {
  var username: String
  var description: String
  var profilePictureUrlString: String?
  var profileHeaderUrlString: String?

  var profilePictureUrl: URL? {
    URL(string: profilePictureUrlString ?? "")
  }

  var profileHeaderUrl: URL? {
    URL(string: profileHeaderUrlString ?? "")
  }

  init(
    username: String,
    description: String,
    profilePictureUrlString: String = "",
    profileHeaderUrlString: String = ""
  ) {
    self.username = username
    self.description = description
    self.profilePictureUrlString = profilePictureUrlString
    self.profileHeaderUrlString = profileHeaderUrlString
  }
}
