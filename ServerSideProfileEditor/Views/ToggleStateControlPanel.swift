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
  var body: some View {
    VStack {
      Toggle(isOn: $showChanges) {
        Text(title)
      }
      HStack {
        Button("Save") {
        }
        .modifier(ControlPanelButtonViewModifier(backgroundColor: .blue))
        Button("Discard Changes") {
        }
        .modifier(ControlPanelButtonViewModifier(backgroundColor: .red))
      }
    }.padding(.vertical, 4)
  }
}