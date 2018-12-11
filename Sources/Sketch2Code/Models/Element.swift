//
//  Element.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//  Copyright © 2018 Sankuai. All rights reserved.
//

import Foundation

extension Sketch {

    struct Element: Codable {

        let id: String
        let name: String
        let frame: Rect
        let symbolID: String?
        let resizingConstraint: ResizingOptions
//        "_class": "text",
        let _class: Class

        enum Class: String, Codable {
            case text
            case symbolInstance
        }

        enum CodingKeys : String, CodingKey {
            case name
            case id = "do_objectID"
            case frame
            case symbolID
            case resizingConstraint
            case _class
        }

    }

}
