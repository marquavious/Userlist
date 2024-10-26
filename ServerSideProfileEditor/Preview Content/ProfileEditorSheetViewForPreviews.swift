//
//  ProfileEditorSheetViewForPreviews.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct ProfileEditorSheetViewForPreviews: View {

  @State var showProfileChanges: Bool = true
  @State var profile = Profile.generatRandomProfile()

  var body: some View {
    ProfileEditorSheetView(
      showProfileChanges: $showProfileChanges,
      profile: profile
    )
  }
}