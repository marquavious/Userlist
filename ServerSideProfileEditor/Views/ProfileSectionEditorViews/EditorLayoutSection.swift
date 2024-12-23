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
  @Binding var separator: Separator

  var body: some View {
    Section("Layout") {
      VStack {
        Picker("Text Position", selection: $alignment) {
          ForEach(SectionLayout.AlignmentGuide.allCases) { option in
            Image(systemName: option.systemImageString)
              .tag(option)
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

        Picker("Separator Type", selection: $separator) {
          ForEach(Separator.allCases) { option in
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
  ProfileSectionEditorViewForPreviews(
    media:
        .urlPhoto(
          photoData: PhotoData(
            id: UUID().uuidString,
            urlString: ProfileStubGenerator.randomMediaPicture(),
            contentMode: .allCases.randomElement()!
          )
        )
  )
}
