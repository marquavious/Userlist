//
//  StretchyHeaderScrollView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import SwiftUI

struct StretchyHeaderScrollView<Content: View>: View {
  
  let url: URL?
  let photoHeight: CGFloat
  var verticalOffset: CGFloat = 0
  var showsIndicators: Bool = false
  let viewBuilder: () -> Content

  var offsetDidChange: ((CGFloat) -> ())

  var body: some View {
    ScrollView(showsIndicators: showsIndicators) {
      GeometryReader { geo in
        Color.clear
          .onChange(of: geo.frame(in: .global).minY) { offsetDidChange( $0) }
      }
      .frame(height: 0) // Invisible view to track offset.

      VStack(alignment: .leading) {
        AsyncImage(url: url) { image in
          image
            .resizable()
            .stretchy()
        } placeholder: {
          Color.gray
        }
        .frame(height: photoHeight)
        viewBuilder()
          .offset(y: verticalOffset)
      }
    }
    .edgesIgnoringSafeArea(.vertical)
  }
}

