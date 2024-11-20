//
//  PhotoView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/19/24.
//

import Foundation
import SwiftUI

struct PhotoView: View {

  var url: URL?

  var body: some View {
    AsyncImage(url: url) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
    } placeholder: {
      Color.gray
    }
    .background(.gray)
    .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
  }
}
