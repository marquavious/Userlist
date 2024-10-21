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
}