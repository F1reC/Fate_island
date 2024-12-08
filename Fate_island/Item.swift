//
//  Item.swift
//  Fate_island
//
//  Created by F1reC on 2024/12/8.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}