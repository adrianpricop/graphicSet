//
//  Card.swift
//  test
//
//  Created by apple on 05/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import Foundation


struct Card: Hashable {
    
    
    var isSelected = false
    var identifier: Int
    
    let cardColor: CardColor
    let cardSimbol: CardSimbol
    let cardNumber: CardNumber
    let cardShading: CardShading
    
    var hashValue: Int
    {
        return identifier.hashValue
    }
    
    
    
//    static var identifierFactori = 0
//
//    static func getUnoqueIdentifier() -> Int
//    {
//        identifierFactori += 1
//        return identifierFactori
//    }
//
//    init()
//    {
//        self.identifier = Card.getUnoqueIdentifier()
//    }
    
    enum CardSimbol
    {
        case square
        case circle
        case triangle

        static let allValues = [square, circle, triangle]
    }
    enum CardColor
    {
        case red
        case green
        case blue

        static let allValues = [red, green, blue]
    }
    enum CardNumber
    {
        case one
        case two
        case three

        static let allValues = [one, two, three]
    }
    enum CardShading
    {
        case full
        case empty
        case stripped

        static let allValues = [full, empty, stripped]
    }
}
