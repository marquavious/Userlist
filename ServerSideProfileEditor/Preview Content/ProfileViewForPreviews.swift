//
//  ProfileViewForPreviews.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import SwiftUI

struct ProfileViewForPreviews: View {

  @State var profile = UserDatabase.shared.allUsers.randomElement()!

  var body: some View {
    ProfileView(profile: profile)
      .withStubbedEnvironments()
  }
}

#Preview {
  ProfileViewForPreviews()
}
