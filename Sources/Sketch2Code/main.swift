//
//  main.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//  Copyright © 2018 Sankuai. All rights reserved.
//

import Foundation
import SwiftSyntax

let filePath = CommandLine.arguments[1] // $SRCROOT/OtherResources/page.json

let pageJSONFileURL = URL(fileURLWithPath: filePath)
let pageJSONData = try Data(contentsOf: pageJSONFileURL)

let jsonDecoder = JSONDecoder()
do {
    let page = try jsonDecoder.decode(Sketch.Page.self, from: pageJSONData)
    print(page)
} catch {
    print(error)
}
