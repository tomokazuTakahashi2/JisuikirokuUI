//
//  Item.swift
//  JisuiKiroku
//
//  Created by 高橋智一 on 2024/04/19.
//

import Foundation
import SwiftData

@Model
final class Item {
    var itemImage: String
    var timestamp: Date
    var title: String
    var ingredients: [Ingredient]
    var directions: [String]
    
    init(itemImage: String,
         timestamp: Date,
         title: String,
         ingredients: [Ingredient],
         directions: [String]) {
        self.itemImage = itemImage
        self.timestamp = timestamp
        self.title = title
        self.ingredients = ingredients
        self.directions = directions
    }
}

struct Ingredient: Codable {
    var name: String
    var quantity: String
}
