//
//  ProfileEditorViewSectionCell.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct ProfileEditorViewSectionCell: View {
  @State var title: String?
  @State var description: String?
  @State var media: Media?

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        if let title {
          Text(title)
            .font(.subheadline)
        }
        if let description {
          Text(description)
            .font(.caption)
        }
        if let media = media {
          Text(media.description)
            .foregroundStyle(.gray)
            .font(.footnote)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      if let media = media {
        MediaWindowView(
          media: media
        )
        .frame(width: 50, height: 50)
        .clipped()
      }
    }
  }
}

#Preview {
  List {
    ProfileEditorViewSectionCell(
      title: "Title",
      description: "Description",
      media: .urlPhoto(
        photoData: .init(
          id: "1",
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!)
      )
    )

    ProfileEditorViewSectionCell(
      title: "Title",
      description: "Description",
      media: .urlPhotoCarousel(
        photoArray: [
          .init(
            id: UUID().uuidString,
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          ),
          .init(
            id: UUID().uuidString,
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          ),
          .init(
            id: UUID().uuidString,
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          ),
          .init(
            id: UUID().uuidString,
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          )
        ]
      )
    )

    ProfileEditorViewSectionCell(
      title: "Title",
      description: "Description",
      media: .urlPhotoGrid(
        photoDataOne: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataTwo: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataThree: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        ),
        photoDataFour: .init(
          id: UUID().uuidString,
          urlString: ProfileStubGenerator.randomMediaPicture(),
          contentMode: .allCases.randomElement()!
        )
      )
    )
  }
}
