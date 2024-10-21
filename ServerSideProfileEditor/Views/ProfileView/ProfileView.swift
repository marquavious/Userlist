//
//  ProfileView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import SwiftUI

struct ProfileView: View {

  var id: String

    var body: some View {
        Text("ProfileView: \(id)")
    }
}

#Preview {
  ProfileView(id: UUID().uuidString)
}
