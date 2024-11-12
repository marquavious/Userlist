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

      CustomDivider()
        .padding(.vertical, 8)
    }
  }
}

struct CustomDivider: View {
  var body: some View {
      Text("_•   •   •_")
      .foregroundStyle(.gray)
      .opacity(0.3)
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
  var mediaPosition: SectionData.Layout

  var body: some View {
    VStack(
      alignment: alignment.horizontalAlignment
    ) {
      Group {
        if mediaIsEmpty {
          VStack(spacing: 4) {
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
            VStack(spacing: 4) {
              createTitleTextView()
              createDescriptionTextView()
            }
          case .middle:
            VStack(spacing: mediaIsEmpty ? 0 : 4) {
              createTitleTextView()
              createMeidaView()
            }
            createDescriptionTextView()
          case .bottom:
            VStack(spacing: (descriptionIsEmpty || titleIsEmpty) ? 0 : 4) {
              createTitleTextView()
              createDescriptionTextView()
            }
            createMeidaView()
          case .flipped:
            createDescriptionTextView()
            VStack(spacing: mediaIsEmpty ? 0 : 4) {
              createMeidaView()
              createTitleTextView()
            }
          }
        }
      }
      .padding(.vertical, Theme.Spacing.intraSectionalHorizontalSpacing.spacing)
    }
  }

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
      .padding(.vertical, 4)
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
