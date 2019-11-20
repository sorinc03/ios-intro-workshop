//
//  Puppies.swift
//  intro-to-ios
//
//  Created by Sorin Cioban on 20/11/2019.
//  Copyright © 2019 Sorin Cioban. All rights reserved.
//

import Foundation

struct Puppy: Codable {
    var name: String?
    var imageName: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case imageName = "picture"
    }
}

struct PuppyResponse: Codable {
    var puppies: [Puppy]?
}

class PuppyManager {
    var puppies: [Puppy]?
    init?() {
        guard let url = Bundle.main.url(forResource: "puppies", withExtension: "json") else {
            fatalError("Could not find puppies JSON file")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let puppyResponse = try decoder.decode(PuppyResponse.self, from: data)
            puppies = puppyResponse.puppies
        } catch {
            print("Could not get valid data \(error)")
        }
    }
}
