//
//  FullSizedPhotoView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/19/24.
//

import Foundation
import SwiftUI

struct FullSizedPhotoView: View {

  struct Constants {
    static let BlurRadius: CGFloat = 5
    static let CornerRadius: CGFloat = StyleConstants.Geometry.cornerRadius
  }

  var url: URL?

  var body: some View {
    AsyncImage(url: url) { image in
      ZStack {
        Rectangle()
          .fill(.clear)
          .overlay {
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .blur(radius: Constants.BlurRadius)
          }
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
    } placeholder: {
      Color.gray
    }
    .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius))
  }
}

#Preview {
  FullSizedPhotoView(
    url: URL(string: ProfileStubGenerator.randomMediaPicture())
  )
  .frame(width: UIScreen.main.bounds.width - 16, height: 200)
}
