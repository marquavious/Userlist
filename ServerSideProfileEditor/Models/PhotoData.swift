//
//  PhotoData.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct PhotoData: Equatable, Identifiable, Hashable {
  let id: String
  var urlString: String?
  let contentMode: ContentMode
}

extension PhotoData {
  static func emptyInstance() -> PhotoData {
    PhotoData(id: UUID().uuidString, urlString: "", contentMode: .fit)
  }

  static func randomInstance() -> PhotoData {
    PhotoData(id: UUID().uuidString, urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .fit)
  }

  static func stubs() -> PhotoData {
    PhotoData(id: UUID().uuidString, urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!)
  }
}
