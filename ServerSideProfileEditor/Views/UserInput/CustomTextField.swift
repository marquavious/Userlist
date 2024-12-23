//
//  CustomTextField.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct CustomTextField: View {

  var title: String
  var textfieldPrompt: String = ""
  var iconSystemImageName: String?
  var isRequired: Bool = false

  @Binding var text: String
  @Environment(\.isFocused) var focused: Bool
  @Environment(\.isEnabled) var isEnabled: Bool

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Group {
          let textPrefix = "\(text.isEmpty && isRequired ? "* " : "")"
          if iconSystemImageName != nil {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
              Text(textPrefix)
                .foregroundStyle((text.isEmpty && isRequired) ? .red : .primary)
              + Text(title)
                .foregroundStyle(.primary)
            }
          } else {
            Text("\(textPrefix)")
              .foregroundStyle((text.isEmpty && isRequired) ? .red : .primary)
            + Text("\(title)")
          }
        }

        HStack {
          if let iconSystemImageName {
            TextField("\(Image(systemName: iconSystemImageName)) \(textfieldPrompt)", text: $text, axis: .vertical)
              .lineLimit(.max, reservesSpace: false)
          } else {
            TextField(textfieldPrompt, text: $text, axis: .vertical)
              .lineLimit(.max, reservesSpace: false)
          }
        }
      }

      Button {
        text = ""
      } label: {
        Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
      }
      .buttonStyle(.plain)
      .opacity(text.isEmpty ? 0 : 1)
      .opacity(focused ? 1 : 0)

    }
    .textFieldStyle(.plain)
    .font(.caption)
    .padding()
    .foregroundStyle(!isEnabled ? Color.gray : .primary)
    .background {
      Rectangle()
        .fill(Color.gray)
        .opacity(0.1)
        .cornerRadius(8)
    }
    .animation(.easeIn(duration: 0.1), value: focused)
  }
}

#Preview {
  ProfileEditorViewForPreviews()
}
