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
    
    
    init(itemImage: String, timestamp: Date, title: String) {
        self.itemImage = itemImage
        self.timestamp = timestamp
        self.title = title
    }
}
