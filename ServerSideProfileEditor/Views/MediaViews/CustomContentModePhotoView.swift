//
//  CustomContentModeImageView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import SwiftUI

struct CustomContentModePhotoView: View {

  struct Constants {
    static let CornerRadius: CGFloat = Theme.Geomitry.cornerRadius.radius
  }

  var url: URL?
  var contentMode: ContentMode

  var body: some View {
    Rectangle()
      .fill(.gray)
      .overlay {
        switch contentMode {
        case .fit:
          BlurredBackgroundPhotoView(url: url)
        case .fill:
          PhotoView(url: url)
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius))
  }
}

#Preview {
  CustomContentModePhotoView(
    url: URL(string: ProfileStubGenerator.randomMediaPicture() ?? ""),
    contentMode: .allCases.randomElement()!
  )
  .frame(width: UIScreen.main.bounds.width - 16, height: 200)
}
