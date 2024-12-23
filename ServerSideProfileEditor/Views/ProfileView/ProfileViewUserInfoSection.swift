//
//  ProfileViewUserInfoSection.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct ProfileViewUserInfoSection: View {
  
  var username: String
  var description: String?
  var profilePictureUrl: URL?
  
  var editButtonPressed: (() -> Void)
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      PhotoView(url: profilePictureUrl)
        .frame(
          width: StyleConstants.MediaSizes.ProfilePicture.profilePictureWidth,
          height: StyleConstants.MediaSizes.ProfilePicture.profilePictureHeight
        )
        .clipShape(Circle())
        .overlay(Circle().stroke(.gray, lineWidth: 1))
      HStack {
        Text("\(username) •")
          .font(.headline)
        Button("Edit Profile") {
          editButtonPressed()
        }
        .buttonStyle(.automatic)
      }
      if let description {
        Text(description)
          .font(.subheadline)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  ProfileViewForPreviews()
}
