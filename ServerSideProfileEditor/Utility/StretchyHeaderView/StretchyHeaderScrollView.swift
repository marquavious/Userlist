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
  
  var body: some View {
    ScrollView(showsIndicators: showsIndicators) {
      VStack {
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

#Preview {
  NavigationStack {
    StretchyHeaderScrollView(
      url: URL(string: ProfileStubGenerator.randomMediaPicture()),
      photoHeight: 200
    ) {
      ForEach(0...10, id: \.self) { _ in
        UserListViewCell(
          title: ProfileStubGenerator.randomUsername(),
          description: ProfileStubGenerator.randomDescription()
        )
      }
    }
  }
}
