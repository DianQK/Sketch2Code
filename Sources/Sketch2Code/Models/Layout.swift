//
//  Layout.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//  Copyright © 2018 Sankuai. All rights reserved.
//

import Foundation

extension Sketch {

    struct Rect: Codable {

        let height: Float
        let width: Float
        let x: Float
        let y: Float

    }

    //https://medium.com/zendesk-engineering/reverse-engineering-sketchs-resizing-functionality-23f6aae2da1a
    struct ResizingOptions: OptionSet, Codable {

        let rawValue: UInt8

        static let none = ResizingOptions(rawValue: 0b111111)
        static let top = ResizingOptions(rawValue: 0b011111)
        static let right = ResizingOptions(rawValue: 0b111110)
        static let bottom = ResizingOptions(rawValue: 0b110111)
        static let left = ResizingOptions(rawValue: 0b111011)

        static let width = ResizingOptions(rawValue: 0b111101)
        static let height = ResizingOptions(rawValue: 0b101111)

        mutating func formUnion(_ other: ResizingOptions) { // 全加起来，合并 0
            if self.rawValue == 0 {
                self = other
            } else {
                self = ResizingOptions(rawValue: self.rawValue & other.rawValue)
            }
        }

        mutating func formIntersection(_ other: ResizingOptions) { // 提取相同的，提取同为 0 的
            if self.rawValue == 0 {
            } else {
                self = ResizingOptions(rawValue: self.rawValue | other.rawValue)
            }
        }

        mutating func formSymmetricDifference(_ other: ResizingOptions) { // 提取不同的，提取为 0 1 的
            if self.rawValue == 0 {
            } else {
                self = ResizingOptions(rawValue: self.rawValue ^ other.rawValue)
            }
        }

    }

}
