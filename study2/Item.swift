//
//  Item.swift
//  study2
//
//  Created by Nilesh Kumar on 14/04/25.
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
