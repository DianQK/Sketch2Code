//
//  UIGenerator.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//

import Foundation
import SwiftSyntax

class UIGenerator {

    let page: Sketch.Page

    init(page: Sketch.Page) {
        self.page = page
    }

    func createSyntax() -> DeclListSyntax {
        var declListSyntax = SyntaxFactory.makeBlankDeclList()
        let importDeclSyntax = ImportDeclSyntax { (builder) in
            builder.useImportTok(SyntaxFactory.makeImportKeyword(trailingTrivia: .spaces(1)))
            builder.useImportKind(SyntaxFactory.makeIdentifier("UIKit", trailingTrivia: .newlines(2)))
        }
        declListSyntax = declListSyntax.appending(importDeclSyntax)
        for artboard in page.layers {
            let viewControllerGenerator = ViewControllerGenerator(artboard: artboard)
            declListSyntax = declListSyntax.appending(viewControllerGenerator.createSyntax())
        }
        return declListSyntax
    }

}
