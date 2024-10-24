//
//  ControlPanelButtonViewModifier.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/24/24.
//

import Foundation
import SwiftUI

struct ControlPanelButtonViewModifier: ViewModifier {

  struct Constants {
    static let buttonHeight: CGFloat = 40
    static let cornerRadius: CGFloat = 8
  }

  var backgroundColor: Color

  func body(content: Content) -> some View {
    content
      .buttonStyle(.plain)
      .frame(maxWidth: .infinity, maxHeight: Constants.buttonHeight)
      .background(backgroundColor)
      .foregroundStyle(.white)
      .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
  }
}
