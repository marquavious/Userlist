//
//  SectionData.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation
import SwiftUICore

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

  enum Alignment: Int, CaseIterable, Equatable {
    case leading, centerd, trailing

    var systemImageString: String {
      switch self {
      case .leading:
        "square.3.layers.3d.top.filled"
      case .centerd:
        "square.3.layers.3d.middle.filled"
      case .trailing:
        "square.3.layers.3d.bottom.filled"
      }
    }

    var horizontalAlignment: HorizontalAlignment {
      switch self {
      case .leading:
          .leading
      case .centerd:
          .center
      case .trailing:
          .trailing
      }
    }
  }

  let id: String
  var index: Int
  var title: String?
  var description: String?
  var mediaPosition: MediaPosition?
  var mediaHeight: CGFloat?
  var mediaContentMode: ContentMode
  var alignment: Alignment
  var media: Media?
  
  init(
    id: String = UUID().uuidString,
    index: Int,
    title: String? = nil,
    description: String? = nil,
    mediaPosition: MediaPosition? = nil,
    mediaHeight: CGFloat? = nil,
    mediaContentMode: ContentMode = .fill,
    alignment: Alignment = .leading,
    media: Media? = nil
  ) {
    self.id = id
    self.index = index
    self.title = title
    self.description = description
    self.mediaPosition = mediaPosition
    self.mediaHeight = mediaHeight
    self.mediaContentMode = mediaContentMode
    self.alignment = alignment
    self.media = media
  }
}

extension SectionData: Equatable, Hashable {
  static func == (lhs: SectionData, rhs: SectionData) -> Bool {
    lhs.id == rhs.id &&
    lhs.index == rhs.index &&
    lhs.title == rhs.title &&
    lhs.description == rhs.description &&
    lhs.mediaPosition == rhs.mediaPosition &&
    lhs.mediaHeight == rhs.mediaHeight &&
    lhs.mediaContentMode == rhs.mediaContentMode &&
    lhs.alignment == rhs.alignment &&
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
      description: stubData.description,
      mediaContentMode: .allCases.randomElement()!,
      media: Media.generateRandomMedia()
    )
  }
}
