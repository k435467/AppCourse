//
//  PlayingCardDeck.swift
//  mobile-app-dev-hw1
//
//  Created by Abbe♡ on 2020/5/21.
//  Copyright © 2020 NTNU. All rights reserved.
//

import Foundation

// a struct has cards array (init each card suit and rank)

struct PlayingCardDeck
{
    private(set) var cards = [PlayingCard]()
    private(set) var sportsCards = [PlayingCard]()
    private(set) var animalsCards = [PlayingCard]()
    private(set) var facesCards = [PlayingCard]()
    
    let emojiChoice = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🎱🥏",
        "Animals": "🐶🐱🐨🙈🐣🐴🐼🐷",
        "Faces": "😀☺️🥰😜😏😣😠😨"
    ]
    
    init(){
        for index in 0...7 {   // to determine emojiIndex frome 0 to 7
            for suit in PlayingCard.Suit.all {
                for rank in PlayingCard.Rank.all {
                    cards.append(PlayingCard(suit: suit, rank: rank, emojiIndex: index, emojiThemeString: "⚽️🏀🏈⚾️🎾🏐🎱🥏") )
                    sportsCards.append(PlayingCard(suit: suit, rank: rank, emojiIndex: index, emojiThemeString: "⚽️🏀🏈⚾️🎾🏐🎱🥏") )
                    animalsCards.append(PlayingCard(suit: suit, rank: rank, emojiIndex: index, emojiThemeString: "🐶🐱🐨🙈🐣🐴🐼🐷") )
                    facesCards.append(PlayingCard(suit: suit, rank: rank, emojiIndex: index, emojiThemeString: "😀☺️🥰😜😏😣😠😨") )
                }
            }
        }
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0{
            return cards.remove(at: cards.count.arc4random)
        } else{
            return nil
        }
    }
    
    mutating func draw(forEmojiTheme theme: String) -> PlayingCard? {
        if cards.count > 0{
            if theme == emojiChoice["Sports"] {
                return sportsCards.remove(at: cards.count.arc4random)
            }
            if theme == emojiChoice["Animals"] {
                return animalsCards.remove(at: cards.count.arc4random)
            }
            if theme == emojiChoice["Faces"] {
                return facesCards.remove(at: cards.count.arc4random)
            }
            return nil
        } else{
            return nil
        }
    }
    
}

extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else{
            return 0
        }
    }
}

