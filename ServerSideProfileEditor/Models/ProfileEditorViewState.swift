//
//  ProfileEditorViewState.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/21/24.
//

import Foundation

class ProfileEditorViewState {
  var usernameText: String = ""
  var descriptionText: String = ""
  var profilePictureURL: String = ""
  var bannerPhotoURL: String = ""

  init(userData: UserData) {
    self.usernameText = userData.username
    self.descriptionText = userData.description
    self.profilePictureURL = userData.profilePictureUrlString ?? ""
    self.bannerPhotoURL = userData.profileBannerUrlString ?? ""
  }

  init(
    usernameText: String = "",
    descriptionText: String = "",
    profilePictureURL: String = "",
    bannerPhotoURL: String = ""
  ) {
    self.usernameText = usernameText
    self.descriptionText = descriptionText
    self.profilePictureURL = profilePictureURL
    self.bannerPhotoURL = bannerPhotoURL
  }
}
