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
    case title, description, profileCellTitle, profileCellDescription

    var font: Font {
      switch self {
      case .title:
          .system(size: 18)
      case .description:
          .system(size: 16)
      case .profileCellTitle:
          .system(size: 16)
      case .profileCellDescription:
          .system(size: 14)
      }
    }
  }

  enum AnimationSpeed: Double {
    case normal = 0.2
  }

  enum MediaSizes {
    case mediaHeight
    case profilePicture
    var height: CGFloat {
      switch self {
      case .mediaHeight:
        200
      case .profilePicture:
        95
      }
    }

    var width: CGFloat {
      switch self {
      case .profilePicture:
        return 95
      default:
        fatalError("Use this purposefully...")
      }
    }
  }

  enum Geomitry {
    case cornerRadius
    var radius: CGFloat {
      switch self {
      case .cornerRadius:
        8
      }
    }
  }

  enum Spacing {
    case intraSectionalHorizontalSpacing
    case profileSectionCellSpacing
    case cellTextSpacing
    var spacing: CGFloat {
      switch self {
      case .intraSectionalHorizontalSpacing:
        4
      case .profileSectionCellSpacing:
        8
      case .cellTextSpacing:
        4
      }
    }
  }

  enum Padding {
    case profileViewHorizontalSpacing
    case userListViewHorizontalSpacing
    var padding: CGFloat {
      switch self {
      case .profileViewHorizontalSpacing, .userListViewHorizontalSpacing:
        16
      }
    }
  }

  enum Button {
    case buttonHeight

    var height: CGFloat {
      switch self {
      case .buttonHeight:
        40
      }
    }
  }
}

#Preview {
  ProfileView(profile: ProfileData.generatRandomProfile())
    .withStubbedEnviorments()
}
