//
//  Theme.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

public struct StyleConstants {

  struct Text {
    static let title = Font.system(size: 18)
    static let description = Font.system(size: 16)
    static let profileCellTitle = Font.system(size: 16)
    static let profileCellDescription = Font.system(size: 14)
  }

  struct AnimationSpeed {
    static let normal: Double = 0.2
  }

  struct MediaSizes {
    static let mediaHeight: CGFloat = 200
    
    struct ProfilePicture {
      static let profilePictureHeight: CGFloat = 95
      static let profilePictureWidth: CGFloat = 95
      static let profileCellPictureHeight: CGFloat = 60
      static let profileCellPictureWidth: CGFloat = 60
    }
  }

  struct Geometry {
    static let cornerRadius: CGFloat = 8
  }

  struct Spacing {
    static let intraSectionalHorizontalSpacing: CGFloat = 4
    static let profileSectionCellSpacing: CGFloat = 8
    static let cellTextSpacing: CGFloat = 4
  }

  struct Padding {
    static let profileViewHorizontalSpacing: CGFloat = 16
    static let userListViewHorizontalSpacing: CGFloat = 16
  }

  struct Button {
    static let buttonHeight: CGFloat = 40
  }
}

#Preview {
  ProfileView(profile: ProfileData.generatRandomProfile())
    .withStubbedEnvironments()
}
