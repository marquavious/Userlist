//
//  SeparatorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/21/24.
//

import Foundation
import SwiftUI

struct SeparatorView: View {

  var separator: Separator

  var body: some View {
    switch separator {
    case .divider:
      Divider()
    case .ellipsis:
      Text("_•   •   •_")
        .foregroundStyle(.gray)
        .opacity(0.3)
    case .none:
      Spacer()
        .frame(height: 0)
    case .spacer:
      Spacer()
    }
  }
}

#Preview {
  SeparatorView(separator: .allCases.randomElement()!)
}

enum Separator: Int, CaseIterable, Hashable, Identifiable, Equatable {
  case ellipsis, divider, spacer, none

  var id: String { systemImageString }

  var systemImageString: String {
    switch self {
    case .ellipsis:
      "ellipsis"
    case .divider:
      // BOOO SF symbols does not contain a simple straight line...
      "divide"
    case .spacer:
      "rectangle.arrowtriangle.2.outward"
    case .none:
      "x.circle"
    }
  }
}
