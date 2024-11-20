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

  var body: some View {
    GeometryReader { proxy in
      ScrollView(.horizontal) {
        HStack {
          ForEach(photoArray) { image in
            CustomContentModePhotoView(
              url: URL(string: image.urlString ?? ""),
              contentMode: image.contentMode
            )
            .frame(width: proxy.frame(in: .global).width)
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

#Preview {
  PhotoCarouselView(
    photoArray: [
      PhotoData.stubs(),
      PhotoData.stubs(),
      PhotoData.stubs(),
      PhotoData.stubs()
    ]
  )
  .frame(
    width: UIScreen.main.bounds.width - 16,
    height: Theme.MediaSizes.mediaHeight.height
  )
}
