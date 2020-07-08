//
//  PlayingCard.swift
//  mobile-app-dev-hw1
//
//  Created by Abbe♡ on 2020/5/21.
//  Copyright © 2020 NTNU. All rights reserved.
//

import Foundation

// a struct has two var, suit and rank, for each card

struct PlayingCard : CustomStringConvertible
{
    var description: String{return "\(rank)\(suit)"}
    
    var suit: Suit
    var rank: Rank
    
    //----------------
    let emojiChoice = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🎱🥏",
        "Animals": "🐶🐱🐨🙈🐣🐴🐼🐷",
        "Faces": "😀☺️🥰😜😏😣😠😨"
    ]
    var emojiIndex: Int
    var emojiThemeName: String = "Sports"
    var emojiThemeString: String
    var emoji: String {
        get {
            var emojiString = emojiChoice[emojiThemeName]
            let tmpIndex = emojiString?.index(emojiString!.startIndex, offsetBy: emojiIndex)
            return String( (emojiString?.remove(at: tmpIndex!))! )
        }
    }
    //----------------
    
    enum Suit: String, CustomStringConvertible{
        var description: String {return rawValue}
        
        case spade = "♠️"
        case heart = "❤️"
        case diamond = "♦️"
        case club = "♣️"
        
        static var all = [Suit.spade, .heart, .diamond, .club]
    }
    
    enum Rank: CustomStringConvertible{
        var description: String{
            switch self{
            case .ace: return "A"
            case .numeric(let pips): return String(pips)
            case .face(let kind): return kind
            }
        }
        
        case ace
        case numeric(pipsCount: Int)
        case face(String)
        
        var order: Int{
            switch self{
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank]{
            var allRanks = [Rank.ace]
            for pips in 2...10{
                allRanks.append(Rank.numeric(pipsCount: pips))
            }
            allRanks += [Rank.face("J"), Rank.face("Q"), Rank.face("K") ]
            return allRanks
        }
    }
    
    
}
