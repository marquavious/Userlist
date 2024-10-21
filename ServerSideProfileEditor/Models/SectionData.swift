//
//  SectionData.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

@Observable
class SectionData: Identifiable, ObservableObject {

  enum MediaPosition: Int, CaseIterable, Equatable {
    case top, middle, bottom

    var systemImageString: String {
      switch self {
      case .top:
        "square.3.layers.3d.top.filled"
      case .middle:
        "square.3.layers.3d.middle.filled"
      case .bottom:
        "square.3.layers.3d.bottom.filled"
      }
    }
  }

  let id: String
  var index: Int
  var title: String?
  var description: String?
  var mediaPosition: MediaPosition?
  var media: Media?

  init(
    id: String = UUID().uuidString,
    index: Int,
    title: String? = nil,
    description: String? = nil,
    mediaPosition: MediaPosition? = nil,
    media: Media? = nil
  ) {
    self.id = id
    self.index = index
    self.title = title
    self.description = description
    self.mediaPosition = mediaPosition
    self.media = media
  }
}

extension SectionData: Equatable, Hashable {
  static func == (lhs: SectionData, rhs: SectionData) -> Bool {
    lhs.id == rhs.id &&
    lhs.index == rhs.index &&
    lhs.title == rhs.title &&
    lhs.description == rhs.description &&
    lhs.media == rhs.media
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension SectionData {
  func copy() -> SectionData {
    SectionData(
      id: id,
      index: index,
      title: title,
      description: description,
      media: media
    )
  }

  static func stubs(
    id: String = UUID().uuidString,
    index: Int = 0
  ) -> SectionData {
    let stubData = ProfileStubGenerator.randomSectionTupleData()
    return SectionData(
      id: id,
      index: index,
      title: stubData.title,
      description: stubData.description
    )
  }
}
