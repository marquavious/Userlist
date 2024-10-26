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
      SectionView(
        title: section.title,
        description: section.description,
        media: section.media,
        horizontalAlignment: section.alignment.horizontalAlignment
      )
      .padding(.horizontal, 16)
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}

struct SectionView: View {
  var title: String?
  var description: String?
  var media: Media?
  var horizontalAlignment: HorizontalAlignment

  var body: some View {
    VStack(
      alignment: horizontalAlignment,
      spacing: Theme.Spacing.profileSectionCellSpacing.spacing
    ) {
      if let title = title, !title.isEmpty {
        Text(title)
          .font(Theme.Text.title.font)
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      if let description = description, !description.isEmpty {
        Text(description)
          .font(Theme.Text.description.font)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      if let media = media {
        MediaView(
          media: media,
          cornerRadius: Theme.Geomitry.cornerRadius.radius
        )
        .frame(height: Theme.MediaSizes.mediaHeight.height)
      }
    }
    .padding(.vertical, Theme.Spacing.intraSectionalHorizontalSpacing.spacing / 2)
  }
}
