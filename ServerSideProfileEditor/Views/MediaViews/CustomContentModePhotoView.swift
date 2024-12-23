//
//  CustomContentModePhotoView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import SwiftUI

struct CustomContentModePhotoView: View {

  struct Constants {
    static let CornerRadius: CGFloat = StyleConstants.Geometry.cornerRadius
  }

  var photoData: PhotoData

  var body: some View {
    Rectangle()
      .fill(.gray)
      .overlay {
        switch photoData.contentMode {
        case .fit:
          FullSizedPhotoView(url: photoData.urlString?.urlValue)
        case .fill:
          PhotoView(url: photoData.urlString?.urlValue)
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius))
  }
}

#Preview {
  CustomContentModePhotoView(photoData: PhotoData.randomInstance())
  .frame(width: UIScreen.main.bounds.width - 16, height: 200)
}
