//
//  PhotoGridView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct PhotoGridView: View {
  @State var cornerRadius: CGFloat
  @State var photoDataOne: PhotoData
  @State var photoDataTwo: PhotoData
  @State var photoDataThree: PhotoData
  @State var photoDataFour: PhotoData

  var body: some View {
    VStack {
      HStack {
        CustomContentModeImageView(
          urlString: photoDataOne.urlString,
          contentMode: photoDataOne.contentMode
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        CustomContentModeImageView(
          urlString: photoDataTwo.urlString,
          contentMode: photoDataTwo.contentMode
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      }
      HStack {
        CustomContentModeImageView(
          urlString: photoDataThree.urlString,
          contentMode: photoDataThree.contentMode
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        CustomContentModeImageView(
          urlString: photoDataFour.urlString,
          contentMode: photoDataFour.contentMode
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      }
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
