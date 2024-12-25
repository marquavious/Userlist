//
//  KeyboardToolbar.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/24/24.
//

import SwiftUI
import Foundation

typealias KeyboardToolBarOption = (id: String, systemImageString: String, tint: Color, action: () -> Void)

struct KeyboardToolbar: View {
  var doneButtonPressed: () -> Void
  var externalOptions: [KeyboardToolBarOption]?

  var body: some View {
    HStack {
      Button("Done") {
        doneButtonPressed()
      }
      .buttonStyle(.bordered)
      .tint(.blue)

      Spacer()

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
}
