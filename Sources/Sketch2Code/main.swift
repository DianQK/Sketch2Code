//
//  main.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//  Copyright © 2018 Sankuai. All rights reserved.
//

import Foundation
import SwiftSyntax
import ZIPFoundation
import CommonCrypto

let sketchFilePath = CommandLine.arguments[1] // $SRCROOT/OtherResources/Example.sketch
let outputPath = CommandLine.arguments[2] // $SRCROOT/Example/Example/UI.swift

let sketchFilePathURL = URL(fileURLWithPath: sketchFilePath)
let sketchUnzipURL = URL(fileURLWithPath: sketchFilePath.replacingOccurrences(of: ".sketch", with: ""))

do { // check sketch md5
    let data = try Data(contentsOf: sketchFilePathURL)
    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    _ = digestData.withUnsafeMutableBytes { digestBytes in
        data.withUnsafeBytes {messageBytes in
            CC_MD5(messageBytes, CC_LONG(data.count), digestBytes)
        }
    }
    let md5Hex = digestData.map { String(format: "%02hhx", $0) }.joined()
    print(md5Hex)
} catch {
    print(error)
}

let fileManager = FileManager.default

try? fileManager.removeItem(at: sketchUnzipURL)

do {
    try fileManager.createDirectory(at: sketchUnzipURL, withIntermediateDirectories: true, attributes: nil)
    try fileManager.unzipItem(at: sketchFilePathURL, to: sketchUnzipURL)
} catch {
    print("Extraction of ZIP archive failed with error:\(error)")
}

let pagesDirectoryURL = sketchUnzipURL.appendingPathComponent("pages", isDirectory: true)
let pageURLs = try fileManager.contentsOfDirectory(at: pagesDirectoryURL, includingPropertiesForKeys: nil, options: [.skipsSubdirectoryDescendants])

if let firstPageURL = pageURLs.first {
    let pageJSONData = try Data(contentsOf: firstPageURL)

    let jsonDecoder = JSONDecoder()
    do {
        let page = try jsonDecoder.decode(Sketch.Page.self, from: pageJSONData)
        let generator = UIGenerator(page: page)
        let syntax = generator.createSyntax()
        print(syntax)
        try syntax.description.write(toFile: outputPath, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        print(error)
    }

}
