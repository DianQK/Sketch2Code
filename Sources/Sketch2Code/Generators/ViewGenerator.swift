//
//  ViewGenerator.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//

import Foundation
import SwiftSyntax

class ViewGenerator {

    let element: Sketch.Element
    var className: String

    var propertyName: String {
        return className
            .replacingCharacters(
                in: className.startIndex..<(className.index(after: className.startIndex)),
                with: String(className.first!).lowercased())
    }

    init(element: Sketch.Element) {
        self.element = element
        self.className = "\(element.name.replacingOccurrences(of: " ", with: ""))View"
    }

    func createSyntax(leadingTriviaSpaces: Int) -> ClassDeclSyntax {
        return ClassDeclSyntax { (builder: inout ClassDeclSyntaxBuilder) in
            builder.useClassKeyword(SyntaxFactory.makeClassKeyword(leadingTrivia: .spaces(leadingTriviaSpaces), trailingTrivia: .spaces(1)))
            builder.useIdentifier(SyntaxFactory.makeIdentifier(className, trailingTrivia: .spaces(1)))
            builder.useInheritanceClause(TypeInheritanceClauseSyntax {
                $0.useColon(SyntaxFactory.makeColonToken(trailingTrivia: .spaces(1)))
                $0.addInheritedType(SyntaxFactory.makeInheritedType(typeName: SyntaxFactory.makeTypeIdentifier("UIView", trailingTrivia: .spaces(1)), trailingComma: nil))
            })
            builder.useMembers(MemberDeclBlockSyntax {
                $0.useLeftBrace(SyntaxFactory.makeLeftBraceToken(trailingTrivia: .newlines(2)))
                // TODO: 子类背景色，子类代码复用
                // TODO: 颜色叠加
                let initDeclSyntax = SyntaxFactory.makeInitializerDecl(
                    attributes: nil,
                    modifiers: SyntaxFactory.makeModifierList([
                        SyntaxFactory.makeDeclModifier(name: SyntaxFactory.makeIdentifier("required", leadingTrivia: .spaces(4 + leadingTriviaSpaces), trailingTrivia: .spaces(1)), detail: nil)
                        ]),
                    initKeyword: SyntaxFactory.makeInitKeyword(),
                    optionalMark: SyntaxFactory.makeUnknown(""),
                    genericParameterClause: nil,
                    parameters: SyntaxFactory.makeParameterClause(
                        leftParen: SyntaxFactory.makeLeftParenToken(),
                        parameterList: SyntaxFactory.makeFunctionParameterList([]),
                        rightParen: SyntaxFactory.makeRightParenToken(trailingTrivia: .spaces(1))
                    ),
                    throwsOrRethrowsKeyword: nil,
                    genericWhereClause: nil,
                    body: CodeBlockSyntax { (codeBlockSyntaxBuilder: inout CodeBlockSyntaxBuilder) in
                        codeBlockSyntaxBuilder.useLeftBrace(SyntaxFactory.makeLeftBraceToken(trailingTrivia: .newlines(1)))
                        codeBlockSyntaxBuilder.addCodeBlockItem(CodeBlockItemSyntax{ (codeBlockItemSyntaxBuilder: inout CodeBlockItemSyntaxBuilder) in
                            var tokenList: [TokenSyntax] = []
                            tokenList.append(contentsOf: [
                                SyntaxFactory.makeUnknown("super.init(frame: CGRect.zero)", leadingTrivia: .spaces(8 + leadingTriviaSpaces), trailingTrivia: .newlines(1))
                                ])
                            if let backgroundColor = element.style.fills?.first?.color {
                                tokenList.append(SyntaxFactory.makeUnknown("self.backgroundColor = \(backgroundColor.rawCode)", leadingTrivia: .spaces(8 + leadingTriviaSpaces), trailingTrivia: .newlines(1)))
                            }
                            codeBlockItemSyntaxBuilder.useItem(SyntaxFactory.makeTokenList(tokenList))
                        })
                        codeBlockSyntaxBuilder.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(4 + leadingTriviaSpaces), trailingTrivia: .newlines(2)))
                    }
                )
                $0.addDecl(initDeclSyntax)
                $0.addDecl(SyntaxFactory.makeInitializerDecl(
                    attributes: nil,
                    modifiers: SyntaxFactory.makeModifierList([
                        SyntaxFactory.makeDeclModifier(name: SyntaxFactory.makeIdentifier("required", leadingTrivia: .spaces(4 + leadingTriviaSpaces), trailingTrivia: .spaces(1)), detail: nil)
                        ]),
                    initKeyword: SyntaxFactory.makeInitKeyword(),
                    optionalMark: SyntaxFactory.makeUnknown("?"),
                    genericParameterClause: nil,
                    parameters: SyntaxFactory.makeParameterClause(
                        leftParen: SyntaxFactory.makeLeftParenToken(),
                        parameterList: SyntaxFactory.makeFunctionParameterList([
                            SyntaxFactory.makeFunctionParameter(
                                attributes: nil,
                                firstName: SyntaxFactory.makeIdentifier("coder", trailingTrivia: .spaces(1)),
                                secondName: SyntaxFactory.makeIdentifier("aDecoder"),
                                colon: SyntaxFactory.makeColonToken(trailingTrivia: .spaces(1)),
                                type: SyntaxFactory.makeTypeIdentifier("NSCoder"),
                                ellipsis: nil,
                                defaultArgument: nil,
                                trailingComma: nil
                            )
                            ]),
                        rightParen: SyntaxFactory.makeRightParenToken(trailingTrivia: .spaces(1))
                    ),
                    throwsOrRethrowsKeyword: nil,
                    genericWhereClause: nil,
                    body: CodeBlockSyntax { (codeBlockSyntaxBuilder: inout CodeBlockSyntaxBuilder) in
                        codeBlockSyntaxBuilder.useLeftBrace(SyntaxFactory.makeLeftBraceToken(trailingTrivia: .newlines(1)))
                        codeBlockSyntaxBuilder.addCodeBlockItem(CodeBlockItemSyntax{ (codeBlockItemSyntaxBuilder: inout CodeBlockItemSyntaxBuilder) in
                            codeBlockItemSyntaxBuilder.useItem(SyntaxFactory.makeUnknown("fatalError(\"init(coder:) has not been implemented\")", leadingTrivia: .spaces(8 + leadingTriviaSpaces), trailingTrivia: .newlines(1)))
                        })
                        codeBlockSyntaxBuilder.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(4 + leadingTriviaSpaces), trailingTrivia: .newlines(2)))
                })
                )
                $0.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(leadingTriviaSpaces), trailingTrivia: .newlines(2)))
            })
        }
    }

    static func makeViewGenerator(element: Sketch.Element) -> ViewGenerator {
        switch element._class {
        case .text:
            return UILabelGenerator(element: element)
        case .symbolInstance, .rectangle:
            return ViewGenerator(element: element)
        }
    }

}

class UILabelGenerator: ViewGenerator {
    
    override init(element: Sketch.Element) {
        super.init(element: element)
        self.className = "\(element.name.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "Label", with: ""))Label"
    }

    override func createSyntax(leadingTriviaSpaces: Int) -> ClassDeclSyntax {
        return ClassDeclSyntax { (builder: inout ClassDeclSyntaxBuilder) in
            builder.useClassKeyword(SyntaxFactory.makeClassKeyword(leadingTrivia: .spaces(leadingTriviaSpaces), trailingTrivia: .spaces(1)))
            builder.useIdentifier(SyntaxFactory.makeIdentifier(className, trailingTrivia: .spaces(1)))
            builder.useInheritanceClause(TypeInheritanceClauseSyntax {
                $0.useColon(SyntaxFactory.makeColonToken(trailingTrivia: .spaces(1)))
                $0.addInheritedType(SyntaxFactory.makeInheritedType(typeName: SyntaxFactory.makeTypeIdentifier("UILabel", trailingTrivia: .spaces(1)), trailingComma: nil))
            })
            builder.useMembers(MemberDeclBlockSyntax {
                $0.useLeftBrace(SyntaxFactory.makeLeftBraceToken(trailingTrivia: .newlines(2)))
                let initDeclSyntax = SyntaxFactory.makeInitializerDecl(
                    attributes: nil,
                    modifiers: SyntaxFactory.makeModifierList([
                        SyntaxFactory.makeDeclModifier(name: SyntaxFactory.makeIdentifier("required", leadingTrivia: .spaces(4 + leadingTriviaSpaces), trailingTrivia: .spaces(1)), detail: nil)
                        ]),
                    initKeyword: SyntaxFactory.makeInitKeyword(),
                    optionalMark: SyntaxFactory.makeUnknown(""),
                    genericParameterClause: nil,
                    parameters: SyntaxFactory.makeParameterClause(
                        leftParen: SyntaxFactory.makeLeftParenToken(),
                        parameterList: SyntaxFactory.makeFunctionParameterList([]),
                        rightParen: SyntaxFactory.makeRightParenToken(trailingTrivia: .spaces(1))
                    ),
                    throwsOrRethrowsKeyword: nil,
                    genericWhereClause: nil,
                    body: CodeBlockSyntax { (codeBlockSyntaxBuilder: inout CodeBlockSyntaxBuilder) in
                        codeBlockSyntaxBuilder.useLeftBrace(SyntaxFactory.makeLeftBraceToken(trailingTrivia: .newlines(1)))
                        codeBlockSyntaxBuilder.addCodeBlockItem(CodeBlockItemSyntax{ (codeBlockItemSyntaxBuilder: inout CodeBlockItemSyntaxBuilder) in
                            var tokenList: [TokenSyntax] = []
                            tokenList.append(contentsOf: [
                                SyntaxFactory.makeUnknown("super.init(frame: CGRect.zero)", leadingTrivia: .spaces(8 + leadingTriviaSpaces), trailingTrivia: .newlines(1)),
                                SyntaxFactory.makeUnknown("self.numberOfLines = 0", leadingTrivia: .spaces(8 + leadingTriviaSpaces), trailingTrivia: .newlines(1)),
                                SyntaxFactory.makeUnknown("self.text = \(String(describing: element.attributedString?.string))", leadingTrivia: .spaces(8 + leadingTriviaSpaces), trailingTrivia: .newlines(1))
                                ])
                            if let MSAttributedStringFontAttributes = element.style.textStyle?.encodedAttributes.MSAttributedStringFontAttribute?.attributes {
                                tokenList.append(SyntaxFactory.makeUnknown("self.font = UIFont(name: \"\(MSAttributedStringFontAttributes.name)\", size: \(MSAttributedStringFontAttributes.size)) ?? UIFont.systemFont(ofSize: \(MSAttributedStringFontAttributes.size))", leadingTrivia: .spaces(8 + leadingTriviaSpaces), trailingTrivia: .newlines(1)))
                            }
                            codeBlockItemSyntaxBuilder.useItem(SyntaxFactory.makeTokenList(tokenList))
                        })
                        codeBlockSyntaxBuilder.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(4 + leadingTriviaSpaces), trailingTrivia: .newlines(2)))
                    }
                )
                $0.addDecl(initDeclSyntax)
                $0.addDecl(SyntaxFactory.makeInitializerDecl(
                    attributes: nil,
                    modifiers: SyntaxFactory.makeModifierList([
                        SyntaxFactory.makeDeclModifier(name: SyntaxFactory.makeIdentifier("required", leadingTrivia: .spaces(4 + leadingTriviaSpaces), trailingTrivia: .spaces(1)), detail: nil)
                        ]),
                    initKeyword: SyntaxFactory.makeInitKeyword(),
                    optionalMark: SyntaxFactory.makeUnknown("?"),
                    genericParameterClause: nil,
                    parameters: SyntaxFactory.makeParameterClause(
                        leftParen: SyntaxFactory.makeLeftParenToken(),
                        parameterList: SyntaxFactory.makeFunctionParameterList([
                            SyntaxFactory.makeFunctionParameter(
                                attributes: nil,
                                firstName: SyntaxFactory.makeIdentifier("coder", trailingTrivia: .spaces(1)),
                                secondName: SyntaxFactory.makeIdentifier("aDecoder"),
                                colon: SyntaxFactory.makeColonToken(trailingTrivia: .spaces(1)),
                                type: SyntaxFactory.makeTypeIdentifier("NSCoder"),
                                ellipsis: nil,
                                defaultArgument: nil,
                                trailingComma: nil
                            )
                            ]),
                        rightParen: SyntaxFactory.makeRightParenToken(trailingTrivia: .spaces(1))
                    ),
                    throwsOrRethrowsKeyword: nil,
                    genericWhereClause: nil,
                    body: CodeBlockSyntax { (codeBlockSyntaxBuilder: inout CodeBlockSyntaxBuilder) in
                        codeBlockSyntaxBuilder.useLeftBrace(SyntaxFactory.makeLeftBraceToken(trailingTrivia: .newlines(1)))
                        codeBlockSyntaxBuilder.addCodeBlockItem(CodeBlockItemSyntax{ (codeBlockItemSyntaxBuilder: inout CodeBlockItemSyntaxBuilder) in
                            codeBlockItemSyntaxBuilder.useItem(SyntaxFactory.makeUnknown("fatalError(\"init(coder:) has not been implemented\")", leadingTrivia: .spaces(8 + leadingTriviaSpaces), trailingTrivia: .newlines(1)))
                        })
                        codeBlockSyntaxBuilder.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(4 + leadingTriviaSpaces), trailingTrivia: .newlines(2)))
                    })
                )
                $0.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(leadingTriviaSpaces), trailingTrivia: .newlines(2)))
            })
        }
    }

}
