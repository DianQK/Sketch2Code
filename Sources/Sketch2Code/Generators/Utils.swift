//
//  Utils.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//

import Foundation
import SwiftSyntax

struct Utils {

    static func createLetDecl(name: String, type: String, leadingTrivia: Trivia = .zero, trailingTrivia: Trivia = .newlines(1)) -> VariableDeclSyntax {
        // 创建 let 关键字 (`let`)
        let letKeyword = SyntaxFactory.makeLetKeyword(leadingTrivia: leadingTrivia, trailingTrivia: .spaces(1))

        // 根据 name 创建属性名 (`name`)
        let nameId = SyntaxFactory.makeIdentifier(name)

        // 组合类型标记 (比如 `: Int` 部分)
        let typeId = SyntaxFactory.makeTypeIdentifier(type, trailingTrivia: .spaces(1))
        let colon = SyntaxFactory.makeColonToken(trailingTrivia: .spaces(1))
        let typeAnnotation = SyntaxFactory.makeTypeAnnotation(colon: colon, type: typeId)

        let member = IdentifierPatternSyntax { builder in
            builder.useIdentifier(nameId)
        }

        let patterBinding = SyntaxFactory.makePatternBinding(pattern: member,
                                                             typeAnnotation: typeAnnotation,
                                                             initializer: InitializerClauseSyntax { (initializerClauseSyntaxBuilder: inout InitializerClauseSyntaxBuilder) in
                                                                initializerClauseSyntaxBuilder.useEqual(SyntaxFactory.makeEqualToken(trailingTrivia: .spaces(1)))
                                                                initializerClauseSyntaxBuilder.useValue(SyntaxFactory.makeVariableExpr("\(type)()", trailingTrivia: trailingTrivia))
                                                             },
                                                             accessor: nil,
                                                             trailingComma: nil
        )
        let list = SyntaxFactory.makePatternBindingList([patterBinding])

        // 生成属性声明
        return SyntaxFactory.makeVariableDecl(attributes: nil, modifiers: nil, letOrVarKeyword: letKeyword, bindings: list)
    }

}
