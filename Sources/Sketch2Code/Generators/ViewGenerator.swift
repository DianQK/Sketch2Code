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
    let className: String

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
                $0.useRightBrace(SyntaxFactory.makeRightBraceToken(leadingTrivia: .spaces(leadingTriviaSpaces), trailingTrivia: .newlines(2)))
            })
        }
    }

    static func makeViewGenerator(element: Sketch.Element) -> ViewGenerator {
        return ViewGenerator(element: element)
    }

}
