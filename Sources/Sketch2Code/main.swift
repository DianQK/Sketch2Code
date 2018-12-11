//
//  main.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//  Copyright © 2018 Sankuai. All rights reserved.
//

import Foundation
import SwiftSyntax

let filePath = CommandLine.arguments[1] //  $SRCROOT/OtherResources/Example/pages/75A486A4-7B62-49CE-90C1-16027492BCC7.json

let pageJSONFileURL = URL(fileURLWithPath: filePath)
let pageJSONData = try Data(contentsOf: pageJSONFileURL)

let jsonDecoder = JSONDecoder()
do {
    let page = try jsonDecoder.decode(Sketch.Page.self, from: pageJSONData)
    let generator = UIGenerator(page: page)
    print(generator.createSyntax())
} catch {
    print(error)
}
