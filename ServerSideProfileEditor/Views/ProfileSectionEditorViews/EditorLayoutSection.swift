//
//  EditorLayoutSection.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import SwiftUI

struct EditorLayoutSection: View {
  @Binding var alignment: SectionLayout.AlignmentGuide
  @Binding var layout: SectionLayout.Arrangement
  @Binding var media: Media?

  var body: some View {
    Section("Layout") {
      VStack {
        Picker("Text Position", selection: $alignment) {
          ForEach(SectionLayout.AlignmentGuide.allCases) { option in
            Image(systemName: option.systemImageString)
              .tag(option)
              .tint(.blue)
          }
        }
        .pickerStyle(.segmented)

        Picker("Media Position", selection: $layout) {
          ForEach(
            media == nil ?
            SectionLayout.Arrangement.textOnlyCases :
              SectionLayout.Arrangement.allCases
          ) { option in
            Image(systemName: option.systemImageString)
              .tag(option)
          }
        }
        .pickerStyle(.segmented)
      }
    }
  }
}

#Preview {
  ProfileSectionEditorViewForPreview(
    media:
        .urlPhoto(
          photoData: PhotoData(
            id: UUID().uuidString,
            urlString: "https://i.imgur.com/ApCOa7j.jpeg",
            contentMode: .allCases.randomElement()!
          )
        )
  )
}
