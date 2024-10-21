//
//  ProfileStubGenerator.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

struct ProfileStubGenerator {

  static func randomProfilePicture() -> String {
    profilePictures.randomElement()!
  }

  static func randomBannerPicture() -> String {
    banners.randomElement()!
  }

  static func randomMediaPicture() -> String {
    media.randomElement()!
  }

  static func randomUsername() -> String {
    usernames.randomElement()!
  }

  static func randomSectionTupleData() -> (title: String, description: String) {
    [
      (title: "Coffee Shops I Love", description: "I love discovering new coffee shops and trying different blends. Here are some of my favorites."),
      (title: "Books I Recommend", description: "I'm always on the lookout for the next great read. Here are some of my favorite books."),
      (title: "My Fitness Journey", description: "I've been working out regularly for the past year and I've seen a huge improvement in my fitness level."),
      (title: "Favorite Recipes", description: "I love cooking and experimenting with new recipes. Here are some of my favorites."),
      (title: "Creative Projects", description: "I'm a creative person who loves to express myself through art and design."),
      (title: "Travel Destinations", description: "I love traveling and exploring new places. Here are some of my favorite travel destinations."),
      (title: "Gardening Tips", description: "I'm a passionate gardener and I love sharing my tips and tricks."),
      (title: "Favorite Games", description: "I'm a huge gamer and I love playing a variety of games. Here are some of my favorites."),
      (title: "DIY Projects", description: "I love taking on DIY projects and creating things with my own hands."),
      (title: "My Furry Friends", description: "I'm a huge animal lover and I have two adorable pets. Here are their stories.")
    ].randomElement()!
  }

  static func randomUsernameDescriptionBundle() -> (username: String, description: String) {
    [
      (username:"techsavvypro", description:"I'm a passionate coffee enthusiast who loves trying new blends and brewing methods. I also enjoy baking and experimenting with different recipes."),
      (username:"digitalinnovator", description:"As a dedicated bookworm, I'm always on the lookout for the next great read. I love discussing literature and sharing my favorite books with others."),
      (username:"cloudspecialist", description:"I'm a fitness fanatic who enjoys running, hiking, and weightlifting. I believe in the power of exercise to improve both physical and mental health."),
      (username:"datascienceexpert", description:"As a foodie, I love exploring new restaurants and trying different cuisines. I'm also a skilled home cook and enjoy experimenting with new recipes."),
      (username:"aienthusiast", description:"I'm a creative soul who loves painting, drawing, and writing. I find inspiration in the world around me and enjoy sharing my art with others."),
      (username:"webdeveloperpro", description:"As a traveler, I'm always looking for new adventures and experiences. I love exploring different cultures, trying new foods, and meeting new people."),
      (username:"uxdesigner", description:"I'm a gardener who loves spending time tending to my plants. I find gardening to be a relaxing and rewarding hobby."),
      (username:"cybersecurityninja", description:"As a gamer, I love playing video games of all genres. I'm always on the lookout for new games to try and enjoy connecting with other gamers online."),
      (username:"marketingmaestro", description:"I'm a DIY enthusiast who loves taking on home improvement projects. I enjoy the satisfaction of creating something with my own hands."),
      (username:"growthhacker", description:"As a pet lover, I have a deep affection for animals. I love spending time with my pets and volunteering at local animal shelters."),
      (username:"salesguru", description:"I'm a music lover who enjoys listening to a wide variety of genres. I love attending concerts and discovering new artists."),
      (username:"customerchampion", description:"As a movie buff, I'm always up-to-date on the latest releases. I love watching movies with friends and family and discussing them afterwards."),
      (username:"projectmanagerpro", description:"I'm a puzzle enthusiast who loves solving challenging puzzles. I find puzzles to be a great way to relax and exercise my brain."),
      (username:"financewizard", description:"As a nature lover, I'm passionate about protecting the environment. I love spending time in nature and volunteering for environmental causes."),
      (username:"legaleagle", description:"I'm a history buff who loves learning about the past. I enjoy visiting historical sites and reading about historical events."),
      (username:"hrpro", description:"As a sports fan, I'm a passionate supporter of my favorite teams. I love watching games, attending matches, and discussing sports with other fans."),
      (username:"operationsmaster", description:"I'm a language learner who enjoys exploring different cultures through language. I love practicing my language skills and traveling to countries where the language is spoken."),
      (username:"qualityassurance", description:"As a photographer, I love capturing the beauty of the world around me. I enjoy experimenting with different techniques and sharing my photos with others."),
      (username:"leadershipcoach", description:"I'm a collector who enjoys collecting various items, from stamps and coins to vintage toys and books."),
      (username:"innovationcatalyst", description:"As a volunteer, I'm passionate about giving back to my community. I love volunteering for local organizations and making a positive impact on the world.")
    ].randomElement()!
  }

  private static let usernames = [
    "techsavvypro",
    "digitalinnovator",
    "cloudspecialist",
    "datascienceexpert",
    "aienthusiast",
    "webdeveloperpro",
    "uxdesigner",
    "cybersecurityninja",
    "marketingmaestro",
    "growthhacker",
    "salesguru",
    "customerchampion",
    "projectmanagerpro",
    "financewizard",
    "legaleagle",
    "hrpro",
    "operationsmaster",
    "qualityassurance",
    "leadershipcoach",
    "innovationcatalyst"
  ]

  private static let descriptions = [
    "I'm a passionate coffee enthusiast who loves trying new blends and brewing methods. I also enjoy baking and experimenting with different recipes.",
    "As a dedicated bookworm, I'm always on the lookout for the next great read. I love discussing literature and sharing my favorite books with others.",
    "I'm a fitness fanatic who enjoys running, hiking, and weightlifting. I believe in the power of exercise to improve both physical and mental health.",
    "As a foodie, I love exploring new restaurants and trying different cuisines. I'm also a skilled home cook and enjoy experimenting with new recipes.",
    "I'm a creative soul who loves painting, drawing, and writing. I find inspiration in the world around me and enjoy sharing my art with others.",
    "As a traveler, I'm always looking for new adventures and experiences. I love exploring different cultures, trying new foods, and meeting new people.",
    "I'm a gardener who loves spending time tending to my plants. I find gardening to be a relaxing and rewarding hobby.",
    "As a gamer, I love playing video games of all genres. I'm always on the lookout for new games to try and enjoy connecting with other gamers online.",
    "I'm a DIY enthusiast who loves taking on home improvement projects. I enjoy the satisfaction of creating something with my own hands.",
    "As a pet lover, I have a deep affection for animals. I love spending time with my pets and volunteering at local animal shelters.",
    "I'm a music lover who enjoys listening to a wide variety of genres. I love attending concerts and discovering new artists.",
    "As a movie buff, I'm always up-to-date on the latest releases. I love watching movies with friends and family and discussing them afterwards.",
    "I'm a puzzle enthusiast who loves solving challenging puzzles. I find puzzles to be a great way to relax and exercise my brain.",
    "As a nature lover, I'm passionate about protecting the environment. I love spending time in nature and volunteering for environmental causes.",
    "I'm a history buff who loves learning about the past. I enjoy visiting historical sites and reading about historical events.",
    "As a sports fan, I'm a passionate supporter of my favorite teams. I love watching games, attending matches, and discussing sports with other fans.",
    "I'm a language learner who enjoys exploring different cultures through language. I love practicing my language skills and traveling to countries where the language is spoken.",
    "As a photographer, I love capturing the beauty of the world around me. I enjoy experimenting with different techniques and sharing my photos with others.",
    "I'm a collector who enjoys collecting various items, from stamps and coins to vintage toys and books.",
    "As a volunteer, I'm passionate about giving back to my community. I love volunteering for local organizations and making a positive impact on the world."
  ]

  private static let profilePictures: [String] = [
    "https://cdn.profoto.com/cdn/053149e/contentassets/d39349344d004f9b8963df1551f24bf4/profoto-albert-watson-steve-jobs-pinned-image-original.jpg?width=1280&quality=75&format=jpg",
    "https://imgcdn.stablediffusionweb.com/2024/6/12/4d688bcf-f53b-42b6-a98d-3254619f3b58.jpg"
  ]

  private static let banners: [String] = [
    "https://images.photowall.com/products/56987/outer-space-4.jpg?h=699&q=85",
    "https://upload.wikimedia.org/wikipedia/commons/3/37/Skyline-4582510_1920.jpg"
  ]

  private static let media: [String] = [
    "https://i.imgur.com/ApCOa7j.jpeg",
    "https://i.imgur.com/FRf8t4A.png",
    "https://i.imgur.com/vFTPjU4.png",
    "https://i.natgeofe.com/k/a6c9f195-de20-445d-9d36-745ef56042c5/OG_Colosseum_Ancient-Rome_KIDS_1122.jpg?w=1436&h=978",
    "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  ]
}
