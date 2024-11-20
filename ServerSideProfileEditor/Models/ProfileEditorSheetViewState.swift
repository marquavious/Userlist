//
//  ProfileEditorSheetViewState.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/13/24.
//

import Foundation

@Observable
class ProfileEditorSheetViewState: ObservableObject, Identifiable {
  var userData: User
  var sectionData: [SectionData]

  init(
    userData: User,
    sectionData: [SectionData]
  ) {
    self.userData = userData
    self.sectionData = sectionData
  }

  func copyState(_ state: ProfileEditorSheetViewState) {
    userData = state.userData
    sectionData = state.sectionData
  }
}
