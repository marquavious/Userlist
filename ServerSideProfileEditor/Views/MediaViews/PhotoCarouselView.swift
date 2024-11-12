//
//  PhotoCarouselView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct PhotoCarouselView: View {

  var photoArray: [PhotoData]
  var photoCornerRadius: CGFloat

  var body: some View {
    GeometryReader { proxy in
      ScrollView(.horizontal) {
        HStack {
          ForEach(photoArray) { image in
            CustomContentModeImageView(
              urlString: image.urlString,
              contentMode: image.contentMode
            )
            .frame(width: proxy.frame(in: .global).width)
            .clipShape(RoundedRectangle(cornerRadius: photoCornerRadius))
          }
        }
        .scrollTargetLayout()
      }
      .scrollTargetBehavior(.viewAligned)
      .scrollIndicators(.hidden)
    }
    .scrollClipDisabled()
  }
}
