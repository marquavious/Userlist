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

  enum Layout: Int, Identifiable, CaseIterable, Equatable {
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
    case leading, centerd, trailing

    var systemImageString: String {
      switch self {
      case .leading:
        "text.alignleft"
      case .centerd:
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
      case .centerd:
          .center
      case .trailing:
          .trailing
      }
    }

    var textAlignment: TextAlignment {
      switch self {
      case .leading:
          .leading
      case .centerd:
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
      case .centerd:
          .center
      }
    }
  }

  let id: String
  var index: Int
  var title: String?
  var description: String?
  var layout: Layout
  var mediaHeight: CGFloat?
  var mediaContentMode: ContentMode
  var alignment: AlignmentGuide
  var media: Media?
  
  init(
    id: String = UUID().uuidString,
    index: Int = 0,
    title: String? = nil,
    description: String? = nil,
    layout: Layout = .top,
    mediaHeight: CGFloat? = nil,
    mediaContentMode: ContentMode = .fill,
    alignment: AlignmentGuide = .leading,
    media: Media? = nil
  ) {
    self.id = id
    self.index = index
    self.title = title
    self.description = description
    self.layout = layout
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
    lhs.layout == rhs.layout &&
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
      layout: SectionData.Layout.allCases.randomElement() ?? .top,
      mediaContentMode: .allCases.randomElement()!,
      alignment: .leading,
      media: Bool.random() ? nil : Media.generateRandomMedia()
    )
  }
}
