//
//  SeperatorView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/21/24.
//

import Foundation
import SwiftUI

enum Seperator: Int, CaseIterable, Hashable, Identifiable, Equatable {
  case ellipsis, divider, spacer, none

  var id: String { systemImageString }

  var systemImageString: String {
    switch self {
    case .ellipsis:
      "ellipsis"
    case .divider:
      // BOOO SF sybols does not contain a simple straight line...
      "divide"
    case .spacer:
      "rectangle.arrowtriangle.2.outward"
    case .none:
      "x.circle"
    }
  }
}

struct SeperatorView: View {

  var seperator: Seperator

  var body: some View {
    switch seperator {
    case .divider:
      Divider()
        .padding(.vertical, 8)
    case .ellipsis:
      Text("_•   •   •_")
        .foregroundStyle(.gray)
        .opacity(0.3)
        .padding(.vertical, 8)
    case .none:
      Spacer()
        .frame(height: 0)
    case .spacer:
      Spacer()
        .frame(height: 16)
    }
  }
}

#Preview {
  SeperatorView(seperator: .allCases.randomElement()!)
}
