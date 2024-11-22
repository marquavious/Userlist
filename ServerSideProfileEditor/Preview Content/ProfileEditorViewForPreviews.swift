//
//  ProfileEditorViewForPreviews.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/21/24.
//

import Foundation
import SwiftUI

struct ProfileEditorViewForPreviews: View {
  @State var showProfileChanges: Bool = false
  @State var profile: UserData = UserData.stubs().first!
  @State var updatedProfile: UserData = UserData.stubs().last!

  var body: some View {
    ProfileEditorView(
      initialUser: profile,
      userDidUpdate: { _ in }
    )
  }
}
