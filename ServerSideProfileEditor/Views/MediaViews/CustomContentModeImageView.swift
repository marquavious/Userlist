//
//  CustomContentModeImageView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import SwiftUI

struct CustomContentModeImageView: View {

  var urlString: String?
  var contentMode: ContentMode

  var body: some View {
    Rectangle()
      .fill(.gray)
      .overlay {
        if contentMode == .fit {
          ZStack {
            AsyncImage(url: URL(string: urlString ?? "")) { image in
              Rectangle()
                .fill(.clear)
                .overlay {
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 5)
                }
            } placeholder: {
              Color.gray
            }
            .background(.gray)
            .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))

            AsyncImage(url: URL(string: urlString ?? "")) { image in
              image
                .resizable()
                .aspectRatio(contentMode: contentMode)
            } placeholder: {
              Color.gray
            }
            .background(.gray)
          }
        } else {
          AsyncImage(url: URL(string: urlString ?? "")) { image in
            image
              .resizable()
              .aspectRatio(contentMode: contentMode)
          } placeholder: {
            Color.gray
          }
          .background(.gray)
          .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
        }
      }
  }
}

#Preview {
  CustomContentModeImageView(contentMode: .fill)
}
