//
//  Page.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//  Copyright © 2018 Sankuai. All rights reserved.
//

import Foundation

extension Sketch {

    struct Page: Codable {

        let id: String
        let name: String
        let layers: [Artboard]

        enum CodingKeys : String, CodingKey {
            case name
            case id = "do_objectID"
            case layers
        }

    }

}
