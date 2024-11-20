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

  private var titleIsEmpty: Bool {
    if let title = title {
      return title.isEmpty
    } else {
      return true
    }
  }

  private var descriptionIsEmpty: Bool {
    if let description = description {
      return description.isEmpty
    } else {
      return true
    }
  }

  private var mediaIsEmpty: Bool {
    media == nil
  }

  var body: some View {
    VStack(
      alignment: alignment.horizontalAlignment
    ) {
      Group {
        if mediaIsEmpty {
          VStack(spacing: Theme.Spacing.cellTextSpacing.spacing) {
            if mediaPosition == .flipped {
              createDescriptionTextView()
              createTitleTextView()
            } else {
              createTitleTextView()
              createDescriptionTextView()
            }
          }
        } else {
          switch mediaPosition {
          case .top:
            createMeidaView()
            VStack(spacing: Theme.Spacing.cellTextSpacing.spacing) {
              createTitleTextView()
              createDescriptionTextView()
            }
          case .middle:
            VStack(spacing: mediaIsEmpty ? 0 : Theme.Spacing.cellTextSpacing.spacing) {
              createTitleTextView()
              createMeidaView()
            }
            createDescriptionTextView()
          case .bottom:
            VStack(spacing: (descriptionIsEmpty || titleIsEmpty) ? 0 : Theme.Spacing.cellTextSpacing.spacing) {
              createTitleTextView()
              createDescriptionTextView()
            }
            createMeidaView()
          case .flipped:
            createDescriptionTextView()
            VStack(spacing: mediaIsEmpty ? 0 : Theme.Spacing.cellTextSpacing.spacing) {
              createMeidaView()
              createTitleTextView()
            }
          }
        }
      }
      .padding(.vertical, Theme.Spacing.intraSectionalHorizontalSpacing.spacing)
    }
  }

  @ViewBuilder
  private func createTitleTextView() -> some View {
    if let title = title, !title.isEmpty {
      Text(title)
        .font(Theme.Text.title.font)
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity, alignment: alignment.frameAlignment)
        .multilineTextAlignment(alignment.textAlignment)
    }
  }

  @ViewBuilder
  private func createDescriptionTextView() -> some View {
    if let description = description, !description.isEmpty {
      Text(description)
        .font(Theme.Text.description.font)
        .frame(maxWidth: .infinity,  alignment: alignment.frameAlignment)
        .multilineTextAlignment(alignment.textAlignment)
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
      .padding(.vertical, Theme.Spacing.cellTextSpacing.spacing)
    }
  }
}

#Preview {
  SectionCell(alignment: .leading, mediaPosition: .bottom)
}
