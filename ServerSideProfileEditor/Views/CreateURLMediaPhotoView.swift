//
//  CreateURLMediaPhotoView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

typealias CreateURLMediaPhotoViewOption = (id: String, systemImageString: String, tint: Color, action: () -> Void)

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

    static func optionFor(contentMode: ContentMode) -> Self {
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

  @Binding var url: String
  @State var contentMode: ContentModeOption
  @FocusState var isFocused: Bool
  @State var externalOptions: [CreateURLMediaPhotoViewOption]?

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

        if let externalOptions {
          ForEach(externalOptions, id: \.id) { option in
            Button {
              option.action()
            } label : {
              Image(systemName: option.systemImageString)
                .renderingMode(.template)
                .frame(height: 18)
            }
            .buttonStyle(.bordered)
            .tint(option.tint)

          }
        }
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

//#Preview {
//  CreateURLMediaPhotoView(contentMode: .fill) { _ in
//
//  }
//}
