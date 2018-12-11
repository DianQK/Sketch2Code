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
        let _class: Class
        
        let attributedString: AttributedString?
        let style: Style

        enum Class: String, Codable {
            case text
            case symbolInstance
            case rectangle
        }

        enum CodingKeys : String, CodingKey {
            case name
            case id = "do_objectID"
            case frame
            case symbolID
            case resizingConstraint
            case _class
            case attributedString
            case style
        }

    }

}
