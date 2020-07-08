//
//  ConcentrationViewController.swift
//  mobile-app-dev-hw1
//
//  Created by Abbe♡ on 2020/5/21.
//  Copyright © 2020 NTNU. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    var deck = PlayingCardDeck()
    
    @IBOutlet var cardViews: [PlayingCardView]!
    
    //-----------------
    var theme: String?
    {
        didSet {
            if cardViews != nil {
                for cardView in cardViews {
                    cardView.emojiThemeString = theme!
                }
            }
        }
    }
    //-----------------
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior(in: animator)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cards = [PlayingCard]()
        
        for _ in 1...((cardViews.count+1)/2){
            
            if theme != nil {
                let card = deck.draw(forEmojiTheme: theme!)!
                cards += [card, card]
            } else {
                let card = deck.draw()!
                cards += [card, card]
            }
        }
    
        for cardView in cardViews{
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.emoji = card.emoji
            cardView.emojiIndex = card.emojiIndex
            cardView.emojiThemeString = card.emojiThemeString
//            cardView.emojiTheme = card.emojiThemeName
            cardView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self, action: #selector(flipCard(_:) ) ))
            
            cardBehavior.addItem(cardView)
        }
    }

    private var faceUpCardViews: [PlayingCardView]{
        return cardViews.filter{ $0.isFaceUp && !$0.isHidden }
    }

    private var faceUpCardViewMatch: Bool{
//        return faceUpCardViews.count == 2 && faceUpCardViews[0].rank == faceUpCardViews[1].rank && faceUpCardViews[0].suit == faceUpCardViews[1].suit
        return faceUpCardViews.count == 2 && faceUpCardViews[0].emoji == faceUpCardViews[1].emoji
    }
    
    
    
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer){
        switch recognizer.state{
        case .ended:
            if let chosenCardView = recognizer.view as? PlayingCardView{
                UIView.transition(with: chosenCardView,
                                  duration: 0.6,
                                  options: [.transitionFlipFromLeft],
                                  animations: {
                                    chosenCardView.isFaceUp = !chosenCardView.isFaceUp
                                    },
                                    completion: { _ in
                                        if self.faceUpCardViewMatch{
                                            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6,
                                                                                           delay: 0,
                                                                                           options: [],
                                                                                           animations: { self.faceUpCardViews.forEach{
                                                                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                                                                                }
                                                                                            },
                                                                                            completion:{ _ in
                                                                                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.75,
                                                                                                delay: 0,
                                                                                                options: [],
                                                                                                animations: { self.faceUpCardViews.forEach{
                                                                                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                                                                    $0.alpha = 0
                                                                                                 }
                                                                                                 },
                                                                                                completion: { _ in
                                                                                                    self.faceUpCardViews.forEach{
                                                                                                        $0.isHidden = true
                                                                                                        $0.alpha = 1
                                                                                                        $0.transform = .identity
                                                                                                    }
                                                                                                    
                                                                                                }
                                                                                                )
                                                                                                }
                                                                                        )
                                                                                           
                                        }
                                        else if self.faceUpCardViews.count == 2{
                                            self.faceUpCardViews.forEach{ cardView in
                                                UIView.transition(with: cardView,
                                                                  duration: 0.6,
                                                                  options: [.transitionFlipFromLeft],
                                                                  animations: {
                                                                      cardView.isFaceUp = false
                                                                  },
                                                                  completion: { _ in
                                                                    self.cardBehavior.push(cardView)
                                                                  }
                                                    )
                                            }
                                        }
                                        
                                    }
                                  )
            }
        default:
            break
        }
    }
    
}

