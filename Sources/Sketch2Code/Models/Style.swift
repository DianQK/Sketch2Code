//
//  Style.swift
//  Sketch2Code
//
//  Created by DianQK on 2018/12/11.
//

import Foundation

extension Sketch {

    struct Style: Codable {
        
        struct TextStyle: Codable {
            
            let encodedAttributes: EncodedAttributes
            
            struct EncodedAttributes: Codable {
            
                let MSAttributedStringFontAttribute: FontDescriptor?
                
                struct FontDescriptor: Codable {
                    
                    struct Attributes: Codable {
                        
                        let name: String
                        let size: Float
                        
                    }
                    
                    let attributes: Attributes?
                    
                }
                
            }
            
        }
        
        let textStyle: TextStyle?
        
        struct Fill: Codable {
            
            struct Color: Codable {

                let alpha: Double
                let blue: Double
                let green: Double
                let red: Double
                
                var rawCode: String {
                    return "UIColor(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha))"
                }
                
            }
            
            let color: Color
            
        }
        
        let fills: [Fill]?
        
    }
    
}
