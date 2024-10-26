//
//  ProfileSectionEditorViewForPreview.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct ProfileSectionEditorViewForPreview: View {

  @State var titleText: String?
  @State var sectionData: SectionData?
  @State var media: Media?

  var body: some View {
    ProfileSectionEditorView(
      sectionData: sectionData ?? SectionData.stubs(),
      titleText: titleText ??  ProfileStubGenerator.randomSectionTupleData().title,
      media: media) { _ in

      }
  }
}
