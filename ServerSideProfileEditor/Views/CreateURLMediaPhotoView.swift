//
//  CreateURLMediaPhotoView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct CreateURLMediaPhotoView: View {

  private struct Constants {
    static let completionDelay: Int = 1_500
  }

  enum ContentModeOption: Hashable, CaseIterable, Identifiable {
    case fit, fill

    var id: String { UUID().uuidString }

    var contentMode: ContentMode {
      switch self {
      case .fit:
          .fit
      case .fill:
          .fill
      }
    }

    static func optionMode(contentMode: ContentMode) -> Self {
      switch contentMode {
      case ContentMode.fill:
        ContentModeOption.fill
      case ContentMode.fit:
        ContentModeOption.fit
      }
    }

    var systemImage: String {
      switch self {
      case .fit:
        "squareshape.dotted.squareshape"
      case .fill:
        "squareshape.squareshape.dotted"
      }
    }
  }

  @State var url: String = ""
  @State var contentMode: ContentModeOption
  @FocusState var isFocused: Bool

  let didUpdateUrl: ((PhotoData) -> Void)

  var body: some View {
    VStack {
      CustomTextField(
        title: "URL",
        textfieldPrompt: "URL...",
        iconSystemImageName: "link",
        isRequired: true,
        text: $url
      )
      .environment(\.isFocused, isFocused)
      .focused($isFocused, equals: true)
      HStack {
        Text("Frame:")
        Picker("", selection: $contentMode) {
          ForEach(ContentModeOption.allCases) { option in
            Image(systemName: option.systemImage)
              .tag(option)
              .tint(.blue)
          }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: .infinity)
        .pickerStyle(.segmented)
      }
    }
    .onChange(of: url) {
      didUpdate()
    }.onChange(of: contentMode) {
      didUpdate()
    }
  }

  private func didUpdate() {
    didUpdateUrl(
      PhotoData(
        id: UUID().uuidString,
        urlString: url,
        contentMode: contentMode.contentMode
      )
    )
  }
}


