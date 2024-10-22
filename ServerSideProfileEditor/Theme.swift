//
//  Theme.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
public final class Theme {
  enum Text {
    case title, description
    
    var font: Font {
      switch self {
      case .title:
          .system(size: 16)
      case .description:
          .system(size: 14)
      }
    }
  }
  enum MediaSizes {
    case mediaHeight
    var height: CGFloat {
      switch self {
      case .mediaHeight:
        return 250
      }
    }
  }

  enum Geomitry {
    case cornerRadius
    var radius: CGFloat {
      switch self {
      case .cornerRadius:
        return 8
      }
    }
  }

  enum Spacing {
    case intraSectionalHorizontalSpacing
    case profileSectionCellSpacing
    var spacing: CGFloat {
      switch self {
      case .intraSectionalHorizontalSpacing:
        return 8
      case .profileSectionCellSpacing:
        return 8
      }
    }
  }
}
