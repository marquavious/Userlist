//
//  SectionLayout.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/19/24.
//

import Foundation
import SwiftUI

enum SectionLayout {
  enum Arrangement: Int, Identifiable, CaseIterable, Equatable {
    case top, middle, bottom, flipped

    static let textOnlyCases: [Self] = [.top, .flipped]

    var id: String { UUID().uuidString }

    var systemImageString: String {
      switch self { 
      case .top:
        "square.3.layers.3d.top.filled"
      case .middle:
        "square.3.layers.3d.middle.filled"
      case .bottom:
        "square.3.layers.3d.bottom.filled"
      case .flipped:
        "arrow.up.arrow.down"
      }
    }
  }

  enum AlignmentGuide: Int, Identifiable, CaseIterable, Equatable {
    case leading, centered, trailing

    var systemImageString: String {
      switch self {
      case .leading:
        "text.alignleft"
      case .centered:
        "text.aligncenter"
      case .trailing:
        "text.alignright"
      }
    }

    var id: String { UUID().uuidString }

    var horizontalAlignment: HorizontalAlignment {
      switch self {
      case .leading:
          .leading
      case .centered:
          .center
      case .trailing:
          .trailing
      }
    }

    var textAlignment: TextAlignment {
      switch self {
      case .leading:
          .leading
      case .centered:
          .center
      case .trailing:
          .trailing
      }
    }

    var frameAlignment: Alignment {
      switch self {
      case .leading:
          .leading
      case .trailing:
          .trailing
      case .centered:
          .center
      }
    }
  }
}
