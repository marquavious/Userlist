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
  var imageSize: CGSize = CGSize(width: 60, height: 60)

  var editButtonPressed: (() -> Void)

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      AsyncImage(url: profilePictureUrl) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        Color.secondary
      }
      .frame(width: imageSize.width, height: imageSize.height)
      .background(.background)
      .background(.gray)
      .clipShape(Circle())
      .overlay(Circle().stroke(.gray, lineWidth: 1))

      HStack {
        Text("\(username) •")
          .font(.headline)
        Button("Edit Profile") {
          editButtonPressed()
        }.buttonStyle(.automatic)
        Spacer()
      }.frame(maxWidth: .infinity)

      if let description {
        Text(description)
          .font(.subheadline)
      }
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
