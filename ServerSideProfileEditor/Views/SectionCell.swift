//
//  SectionCell.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/13/24.
//

import SwiftUI

struct SectionCell: View {

  var title: String?
  var description: String?
  var media: Media?
  var alignment: SectionLayout.AlignmentGuide
  var mediaPosition: SectionLayout.Arrangement

  init(
    title: String? = nil,
    description: String? = nil,
    media: Media? = nil,
    alignment: SectionLayout.AlignmentGuide = .leading,
    mediaPosition: SectionLayout.Arrangement = .top
  ) {
    self.title = title
    self.description = description
    self.media = media
    self.alignment = alignment
    self.mediaPosition = mediaPosition
  }

  init(
    sectionData: SectionData
  ) {
    self.title = sectionData.title
    self.description = sectionData.description
    self.media = sectionData.media
    self.alignment = sectionData.alignment
    self.mediaPosition = sectionData.layout
  }

  var body: some View {
    VStack(
      alignment: alignment.horizontalAlignment,
      spacing: .zero
    ) {
      if media == nil {
        if mediaPosition == .flipped {
          createDescriptionTextView()
          createTitleTextView()
        } else {
          createTitleTextView()
          createDescriptionTextView()
        }
      } else {
        switch mediaPosition {
        case .top:
          createMediaView()
          createTitleTextView()
          createDescriptionTextView()
        case .middle:
          createTitleTextView()
          createMediaView()
          createDescriptionTextView()
        case .bottom:
          createTitleTextView()
          createDescriptionTextView()
          createMediaView()
        case .flipped:
          createDescriptionTextView()
          createMediaView()
          createTitleTextView()
        }
      }
    }
  }

  @ViewBuilder
  private func createTitleTextView() -> some View {
    if let title = title, !title.isEmpty {
      Text(title)
        .font(StyleConstants.Text.title)
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity, alignment: alignment.frameAlignment)
        .multilineTextAlignment(alignment.textAlignment)
        .edgesIgnoringSafeArea(.vertical)
        .padding(.vertical, 4)
    }
  }

  @ViewBuilder
  private func createDescriptionTextView() -> some View {
    if let description = description, !description.isEmpty {
      Text(description)
        .font(StyleConstants.Text.description)
        .frame(maxWidth: .infinity, alignment: alignment.frameAlignment)
        .multilineTextAlignment(alignment.textAlignment)
        .edgesIgnoringSafeArea(.vertical)
        .padding(.vertical, 4)
    }
  }

  @ViewBuilder
  private func createMediaView() -> some View {
    if let media = media {
      MediaWindowView(
        media: media
      )
      .frame(height: StyleConstants.MediaSizes.mediaHeight)
      .edgesIgnoringSafeArea(.vertical)
      .padding(.vertical, 8)
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
