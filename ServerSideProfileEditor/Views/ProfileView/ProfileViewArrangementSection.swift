//
//  ProfileViewArrangementSection.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct ProfileViewArrangementSection: View {

  var sections: [SectionData]

  var body: some View {
    ForEach(sections) { section in
      SectionCell(
        title: section.title,
        description: section.description,
        media: section.media,
        alignment: section.alignment,
        mediaPosition: section.layout
      )
      CustomDivider()
        .padding(.vertical, 8)
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
