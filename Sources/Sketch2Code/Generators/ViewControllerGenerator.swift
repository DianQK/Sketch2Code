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
                    modifiers: SyntaxFactory.makeModifierList([
                        SyntaxFactory.makeDeclModifier(name: SyntaxFactory.makeIdentifier("override", leadingTrivia: .spaces(4), trailingTrivia: .spaces(1)), detail: nil)
                        ]),
                    funcKeyword: SyntaxFactory.makeFuncKeyword(trailingTrivia: .spaces(1)),
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

                            let addSubviewsSyntaxes: [TokenSyntax] = viewGenerators.flatMap { (viewGenerator) -> [TokenSyntax] in
                                return [
                                    SyntaxFactory.makeUnknown("view.addSubview(\(viewGenerator.propertyName))", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)),
                                    SyntaxFactory.makeUnknown("\(viewGenerator.propertyName).translatesAutoresizingMaskIntoConstraints = false", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)),
                                ]
                            }
                            
                            let layoutSyntaxes: [TokenSyntax] = viewGenerators.flatMap { (viewGenerator) -> [TokenSyntax] in
                                
                                var tokenSyntaxes: [TokenSyntax] = []

                                let resizingConstraint = viewGenerator.element.resizingConstraint
                                
                                if resizingConstraint.contains(.left) {
                                    tokenSyntaxes.append(SyntaxFactory.makeUnknown("\(viewGenerator.propertyName).leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: \(viewGenerator.element.frame.x)).isActive = true", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)))
                                }
                                if resizingConstraint.contains(.right) {
                                    let constant = artboard.frame.width - viewGenerator.element.frame.x - viewGenerator.element.frame.width
                                    tokenSyntaxes.append(SyntaxFactory.makeUnknown("\(viewGenerator.propertyName).rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: \(-constant)).isActive = true", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)))
                                }
                                if resizingConstraint.contains(.top) {
                                    // 确定最近的 top view
                                    if let nearestViewGenerator = viewGenerators
                                        .filter({ !($0 === viewGenerator) && (viewGenerator.element.frame.y - ($0.element.frame.height + $0.element.frame.y) > 0) })
                                        .min(by: { (l, r) -> Bool in
                                            let lDistance = viewGenerator.element.frame.y - (l.element.frame.height + l.element.frame.y)
                                            let rDistance = viewGenerator.element.frame.y - (r.element.frame.height + r.element.frame.y)
                                            if rDistance < 0 {
                                                return lDistance <= 0
                                            } else if lDistance < 0 {
                                                return rDistance <= 0
                                            } else {
                                                return lDistance < rDistance
                                            }
                                        }) {
                                        let constant = viewGenerator.element.frame.y - (nearestViewGenerator.element.frame.height + nearestViewGenerator.element.frame.y)
                                        tokenSyntaxes.append(SyntaxFactory.makeUnknown("\(viewGenerator.propertyName).topAnchor.constraint(equalTo: \(nearestViewGenerator.propertyName).bottomAnchor, constant: \(constant)).isActive = true", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)))
                                        print(nearestViewGenerator.className, viewGenerator.className)
                                    } else {
                                        tokenSyntaxes.append(SyntaxFactory.makeUnknown("\(viewGenerator.propertyName).topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: \(viewGenerator.element.frame.y)).isActive = true", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)))
                                        print("view", viewGenerator.className)
                                    }
                                }
                                if resizingConstraint.contains(.bottom) {
                                    let constant = artboard.frame.height - viewGenerator.element.frame.y - viewGenerator.element.frame.height
                                    tokenSyntaxes.append(SyntaxFactory.makeUnknown("\(viewGenerator.propertyName).bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: \(-constant)).isActive = true", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)))
                                }
                                if resizingConstraint.contains(.width) {
                                    tokenSyntaxes.append(SyntaxFactory.makeUnknown("\(viewGenerator.propertyName).widthAnchor.constraint(equalToConstant: \(viewGenerator.element.frame.width)).isActive = true", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)))
                                }
                                if resizingConstraint.contains(.height) {
                                    tokenSyntaxes.append(SyntaxFactory.makeUnknown("\(viewGenerator.propertyName).heightAnchor.constraint(equalToConstant: \(viewGenerator.element.frame.height)).isActive = true", leadingTrivia: .spaces(8), trailingTrivia: Trivia.newlines(1)))
                                }
                                
                                return tokenSyntaxes

                            }

                            codeBlockItemSyntaxBuilder.useItem(SyntaxFactory.makeTokenList(
                                [
                                    SyntaxFactory.makeSuperKeyword(leadingTrivia: .spaces(8), trailingTrivia: []),
                                    SyntaxFactory.makePeriodToken(), // 点语法
                                    SyntaxFactory.makeIdentifier("viewDidLoad"),
                                    SyntaxFactory.makeLeftParenToken(),
                                    SyntaxFactory.makeRightParenToken(trailingTrivia: .newlines(1))
                                ] +
                                [
                                    SyntaxFactory.makeUnknown("view.backgroundColor = .white", leadingTrivia: .spaces(8), trailingTrivia: .newlines(1))
                                ] +
                                [SyntaxFactory.makeUnknown("", trailingTrivia: .newlines(1))] +
                                addSubviewsSyntaxes +
                                [SyntaxFactory.makeUnknown("", trailingTrivia: .newlines(1))] +
                                layoutSyntaxes +
                                [SyntaxFactory.makeUnknown("", trailingTrivia: .newlines(1))]
                            ))
                        })
                        codeBlockSyntaxBuilder.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(4), trailingTrivia: .newlines(1)))
                    }
                )
                $0.addDecl(viewDidLoadDeclSyntax)
                $0.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1), trailingTrivia: .newlines(2)))
            })
        }
        return viewControllerClass
    }

}
