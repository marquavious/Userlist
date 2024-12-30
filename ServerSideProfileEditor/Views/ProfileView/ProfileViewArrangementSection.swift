//
//  ProfileViewArrangementSection.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/23/24.
//

import Foundation
import SwiftUI

struct ProfileViewArrangementSection: View {
  
  var sections: [SectionData]
  
  var body: some View {
    ForEach(sections.sorted(by: { $0.index < $1.index })) { sectionData in
      SectionCell(sectionData: sectionData)
      .padding(.horizontal, StyleConstants.Padding.profileViewHorizontalSpacing)

      SeparatorView(separator: sectionData.separator)
      .frame(alignment: .center)
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}
