//
//  ProfileViewForPreviews.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import SwiftUI

struct ProfileViewForPreviews: View {

  @State var profile = UserListManager.shared.users.randomElement()!

  var body: some View {
    ProfileView(profile: profile)
      .withStubbedEnviorments()
  }
}

#Preview {
  ProfileViewForPreviews()
}
