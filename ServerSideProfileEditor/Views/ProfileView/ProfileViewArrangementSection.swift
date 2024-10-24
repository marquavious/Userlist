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
      VStack(
        alignment: section.alignment.horizontalAlignment,
        spacing: Theme.Spacing.profileSectionCellSpacing.spacing
      ) {
        if let title = section.title {
          Text(title)
            .font(Theme.Text.title.font)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        if let description = section.description {
          Text(description)
            .font(Theme.Text.description.font)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        if let media = section.media {
          MediaView(
            media: media,
            height: Theme.MediaSizes.mediaHeight.height,
            cornerRadius: Theme.Geomitry.cornerRadius.radius
          )
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, Theme.Spacing.intraSectionalHorizontalSpacing.spacing / 2)
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
