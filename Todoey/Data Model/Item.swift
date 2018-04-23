//
//  ItemDataModel.swift
//  Todoey
//
//  Created by Grégory Da Silva on 23/04/2018.
//  Copyright © 2018 Grégory Da Silva. All rights reserved.
//

import Foundation

class Item: Codable {
    var title: String = ""
    var done: Bool = false
}


//The class will be encoded so we need to specify "Encodable" and "Decodable" or just "Codable"
