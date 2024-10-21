//
//  UserListManager.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation

@Observable
class UserListManager: Observable {
  var users = [Profile.generatRandomProfile(), Profile.generatRandomProfile(), Profile.generatRandomProfile()]
}
