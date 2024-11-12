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
        alignment: section.alignment,
        mediaPosition: section.mediaPosition
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
  var alignment: SectionData.Alignment
  var mediaPosition: SectionData.MediaPosition

  var body: some View {
    VStack(
      alignment: alignment.horizontalAlignment,
      spacing: Theme.Spacing.profileSectionCellSpacing.spacing
    ) {
      switch mediaPosition {
      case .top:
        createMeidaView()
        createTitleTextView()
        createDescriptionTextView()
      case .middle:
        createTitleTextView()
        createMeidaView()
        createDescriptionTextView()
      case .bottom:
        createTitleTextView()
        createDescriptionTextView()
        createMeidaView()
      case .flipped:
        createDescriptionTextView()
        createMeidaView()
        createTitleTextView()
      }
    }
    .padding(.vertical, Theme.Spacing.intraSectionalHorizontalSpacing.spacing / 2)
  }

  @ViewBuilder
  private func createTitleTextView() -> some View {
    if let title = title, !title.isEmpty {
      Text(title)
        .font(Theme.Text.title.font)
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity, alignment: alignmeentFor(alignment: alignment))
        .multilineTextAlignment(textAlignmeentFor(alignment: alignment))
    }
  }

  @ViewBuilder
  private func createDescriptionTextView() -> some View {
    if let description = description, !description.isEmpty {
      Text(description)
        .font(Theme.Text.description.font)
        .frame(maxWidth: .infinity,  alignment: alignmeentFor(alignment: alignment))
        .multilineTextAlignment(textAlignmeentFor(alignment: alignment))
    }
  }

  @ViewBuilder
  private func createMeidaView() -> some View {
    if let media = media {
      MediaView(
        media: media,
        cornerRadius: Theme.Geomitry.cornerRadius.radius
      )
      .frame(height: Theme.MediaSizes.mediaHeight.height)
    }
  }

  private func alignmeentFor(alignment: SectionData.Alignment) -> Alignment {
    switch alignment {
    case .leading:
        .leading
    case .centerd:
        .center
    case .trailing:
        .trailing
    }
  }

  private func textAlignmeentFor(alignment: SectionData.Alignment) -> TextAlignment {
    switch alignment {
    case .leading:
        .leading
    case .centerd:
        .center
    case .trailing:
        .trailing
    }
  }
}
