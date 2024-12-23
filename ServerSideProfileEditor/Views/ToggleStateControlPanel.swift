//
//  ToggleStateControlPanel.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct ToggleStateControlPanel: View {
  @State var title: String
  @Binding var showChanges: Bool

  var leftButtonText: String = "Save"
  var rightButtonText: String = "Discard Changes"

  var leftButtonPressed: () -> Void
  var rightButtonPressed: () -> Void

  var body: some View {
    VStack {
      Toggle(isOn: $showChanges) {
        Text(title)
      }
      HStack {
        Button(leftButtonText) {
          leftButtonPressed()
        }
        .modifier(ControlPanelButtonViewModifier(backgroundColor: .blue))
        Button(rightButtonText) {
          rightButtonPressed()
        }
        .modifier(ControlPanelButtonViewModifier(backgroundColor: .red))
      }
    }
      .padding(.vertical, 4)
  }
}
