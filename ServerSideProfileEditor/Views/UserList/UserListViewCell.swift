//
//  UserListViewCell.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

struct UserListViewCell: View {

  var imageURL: URL?
  var title: String
  var description: String

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        PhotoView(url: imageURL)
          .frame(
            width: StyleConstants.MediaSizes.ProfilePicture.profileCellPictureWidth,
            height: StyleConstants.MediaSizes.ProfilePicture.profileCellPictureHeight
          )
          .clipShape(Circle())
          .overlay(Circle().stroke(.gray, lineWidth: 1))

        if !title.isEmpty || !description.isEmpty {
          VStack(alignment: .leading) {
            if !title.isEmpty {
              Text(title)
                .font(StyleConstants.Text.profileCellTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            }
            if !description.isEmpty {
              Text(description)
                .font(StyleConstants.Text.profileCellDescription)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
          }
        }
      }
    }
  }
}

#Preview {
  ScrollView {
    ForEach(0...5, id: \.self) { _ in
      UserListViewCell(
        imageURL: URL(string: ProfileStubGenerator.randomProfilePicture()),
        title: ProfileStubGenerator.randomUsername(),
        description: ProfileStubGenerator.randomDescription())
    }
  }
}
