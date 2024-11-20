//
//  ControlPanelButtonViewModifier.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/24/24.
//

import Foundation
import SwiftUI

struct ControlPanelButtonViewModifier: ViewModifier {

  var backgroundColor: Color

  func body(content: Content) -> some View {
    content
      .buttonStyle(.plain)
      .frame(maxWidth: .infinity, maxHeight: Theme.Button.buttonHeight.height)
      .background(backgroundColor)
      .foregroundStyle(.white)
      .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
  }
}
