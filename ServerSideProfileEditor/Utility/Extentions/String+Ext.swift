//
//  String+Ext.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/23/24.
//

import Foundation

extension String {
  var urlValue: URL? { URL(string: self) }
}
