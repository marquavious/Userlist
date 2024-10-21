//
//  User.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

struct User: Equatable {
  var username: String
  var description: String
  var profilePictureUrlString: String?
  var profileHeaderUrlString: String?

  var profilePictureUrl: URL? {
    URL(string: profilePictureUrlString ?? "")
  }

  var profileHeaderUrl: URL? {
    URL(string: profileHeaderUrlString ?? "")
  }

  init(
    username: String,
    description: String,
    profilePictureUrlString: String = "",
    profileHeaderUrlString: String = ""
  ) {
    self.username = username
    self.description = description
    self.profilePictureUrlString = profilePictureUrlString
    self.profileHeaderUrlString = profileHeaderUrlString
  }
}

extension User {
  static func stubs() -> [User] {
    [
      User(
        username: "nature_lover",
        description: "I'm a passionate nature enthusiast who loves spending time outdoors. From hiking and camping to gardening and wildlife observation, I find solace and inspiration in the beauty of the natural world. I'm always eager to explore new trails, discover hidden gems, and connect with like-minded individuals who share my love for nature.",
        profilePictureUrlString: "https://i.imgur.com/plJyB2s.jpeg",
        profileHeaderUrlString: "https://i.imgur.com/5k2czKu.jpeg"
      ),
      User(
        username: "techBro26",
        description: "As a dedicated tech enthusiast, I'm constantly exploring the latest advancements in technology and staying up-to-date with the latest trends. From software development and cybersecurity to artificial intelligence and virtual reality, I'm fascinated by the endless possibilities that technology offers. I love sharing my knowledge and passion with others and helping them navigate the digital world.",
        profilePictureUrlString: "https://i.imgur.com/2pGsRH7.jpeg",
        profileHeaderUrlString: "https://i.imgur.com/nhX3VEW.jpeg"
      ),
      User(
        username: "the_music_enthusiast",
        description: "Music is my life. I'm a passionate music lover who enjoys discovering new artists, exploring different genres, and attending live concerts. From classical to rock, jazz to hip-hop, I appreciate the power of music to evoke emotions, connect with others, and inspire creativity. I'm always on the lookout for new music recommendations and love sharing my favorite songs and albums with friends and family.",
        profilePictureUrlString: "https://i.imgur.com/4ZbGm7q.jpeg",
        profileHeaderUrlString: "https://i.imgur.com/MSnYnPh.jpeg"
      )
    ]
  }
}
