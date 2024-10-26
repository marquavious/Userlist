//
//  ProfileSectionEditorViewForPreview.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct ProfileSectionEditorViewForPreview: View {
  var body: some View {
    ProfileSectionEditorView(
      sectionData: SectionData.stubs()) { _ in }
  }
}
