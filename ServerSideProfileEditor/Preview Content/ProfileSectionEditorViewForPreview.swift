//
//  ProfileSectionEditorViewForPreview.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct ProfileSectionEditorViewForPreview: View {

  @State var sectionData: SectionData

  init(
    titleText: String? = "",
    descriptionText: String? = "",
    media: Media? = nil
  ) {
    self.sectionData = SectionData(
      title: titleText,
      description: descriptionText,
      media: media
    )
  }

  init(sectionData: SectionData) {
    self.sectionData = sectionData
  }

  var body: some View {
    ProfileSectionEditorView(sectionData: sectionData) { _ in

    }
  }
}
