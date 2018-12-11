//
//  ViewControllerGenerator.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//

import Foundation
import SwiftSyntax

class ViewControllerGenerator {

    let artboard: Sketch.Artboard
    let className: String

    init(artboard: Sketch.Artboard) {
        self.artboard = artboard
        self.className = "\(artboard.name.replacingOccurrences(of: " ", with: ""))ViewController"
    }

    func createSyntax() -> ClassDeclSyntax {
        let viewControllerClass = ClassDeclSyntax { (builder: inout ClassDeclSyntaxBuilder) in
            builder.useClassKeyword(SyntaxFactory.makeClassKeyword(trailingTrivia: .spaces(1)))
            builder.useIdentifier(SyntaxFactory.makeIdentifier(className, trailingTrivia: .spaces(1)))
            builder.useInheritanceClause(TypeInheritanceClauseSyntax {
                $0.useColon(SyntaxFactory.makeColonToken(trailingTrivia: .spaces(1)))
                $0.addInheritedType(SyntaxFactory.makeInheritedType(typeName: SyntaxFactory.makeTypeIdentifier("UIViewController", trailingTrivia: .spaces(1)), trailingComma: nil))
            })
            builder.useMembers(MemberDeclBlockSyntax {
                $0.useLeftBrace(SyntaxFactory.makeLeftBraceToken(trailingTrivia: .newlines(2)))

                let viewGenerators = artboard.layers.map(ViewGenerator.makeViewGenerator)

                for viewGenerator in viewGenerators {
                    let viewSyntax = viewGenerator.createSyntax(leadingTriviaSpaces: 4)
                    $0.addDecl(viewSyntax)
                    $0.addDecl(Utils.createLetDecl(name: viewGenerator.propertyName, type: viewGenerator.className, leadingTrivia: .spaces(4), trailingTrivia: .newlines(2)))
                }

                let viewDidLoadDeclSyntax = SyntaxFactory.makeFunctionDecl(
                    attributes: nil,
                    modifiers: nil,
                    funcKeyword: SyntaxFactory.makeFuncKeyword(leadingTrivia: .spaces(4), trailingTrivia: .spaces(1)),
                    identifier: SyntaxFactory.makeIdentifier("viewDidLoad"),
                    genericParameterClause: nil,
                    signature: FunctionSignatureSyntax { (functionSignatureSyntaxBuilder: inout FunctionSignatureSyntaxBuilder) in
                        functionSignatureSyntaxBuilder.useInput(ParameterClauseSyntax { (parameterClauseSyntaxBuilder: inout ParameterClauseSyntaxBuilder) in
                            parameterClauseSyntaxBuilder.useLeftParen(SyntaxFactory.makeLeftParenToken(leadingTrivia: .spaces(1), trailingTrivia: []))
                            parameterClauseSyntaxBuilder.useRightParen(SyntaxFactory.makeRightParenToken(trailingTrivia: .spaces(1)))
                        })
                    },
                    genericWhereClause: nil,
                    body: CodeBlockSyntax { (codeBlockSyntaxBuilder: inout CodeBlockSyntaxBuilder) in
                        codeBlockSyntaxBuilder.useLeftBrace(SyntaxFactory.makeLeftBraceToken(trailingTrivia: .newlines(1)))
                        codeBlockSyntaxBuilder.addCodeBlockItem(CodeBlockItemSyntax { (codeBlockItemSyntaxBuilder: inout CodeBlockItemSyntaxBuilder) in

                            let addSubviewsSyntaxs: [TokenSyntax] = viewGenerators.flatMap { (viewGenerator) -> [TokenSyntax] in
                                return [
                                    SyntaxFactory.makeUnknown("view.addSubview(\(viewGenerator.propertyName))", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1))
                                ]
                            }

                            codeBlockItemSyntaxBuilder.useItem(SyntaxFactory.makeTokenList(
                                [
                                    SyntaxFactory.makeSuperKeyword(leadingTrivia: .spaces(8), trailingTrivia: []),
                                    SyntaxFactory.makePeriodToken(), // 点语法
                                    SyntaxFactory.makeIdentifier("viewDidLoad"),
                                    SyntaxFactory.makeLeftParenToken(),
                                    SyntaxFactory.makeRightParenToken(trailingTrivia: .newlines(1))
                                ] +
                                [SyntaxFactory.makeUnknown("", trailingTrivia: .newlines(1))] +
                                addSubviewsSyntaxs +
                                [SyntaxFactory.makeUnknown("", trailingTrivia: .newlines(1))]
                            ))
                        })
                        codeBlockSyntaxBuilder.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(4), trailingTrivia: .newlines(1)))
                    }
                )
                $0.addDecl(viewDidLoadDeclSyntax)
                $0.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1), trailingTrivia: .newlines(1)))
            })
        }
        return viewControllerClass
    }

}
