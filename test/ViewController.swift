//
//  ViewController.swift
//  test
//
//  Created by apple on 05/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        game.cardGenerator()
        updateViewFromModel()
        drawThreeCardsButton.noSelect()
        showSetButton.noSelect()
        newGameButton.noSelect()
        scoreBord.layer.masksToBounds = true
        scoreBord.layer.cornerRadius = 10
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var drawThreeCardsButton: UIButton!
    
    @IBOutlet weak var showSetButton: UIButton!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var scoreBord: UILabel!
    
    var selectedCards = [Int]()
    
    var game = SetGame()
    
    var renderCard = cardRender()
    
    @IBAction func newGameButton(_ sender: Any)
    {
        game.newGame()
        updateViewFromModel()
    }
    
    @IBAction func showSet(_ sender: UIButton)
    {
        if game.findSet()
        {
            updateViewFromModel()
        }
    }
    @IBAction func drawThreeCards(_ sender: UIButton)
    {
        game.drawThreeCards()
        updateViewFromModel()
        
    }
    @IBAction func selectCard(_ sender: UIButton)
    {
        if let cardNumeber = cardButtons.index(of: sender)
        {
            game.selectCard(at: cardNumeber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel()
    {
        
        
        for index in cardButtons.indices
        {
            let score = game.score
            let button = cardButtons[index]

            
            if index < game.inPlayCards.count
            {
                
                let card = game.inPlayCards[index]
                renderCard.renderCard(for: card, for: button)
                
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                scoreBord.text = "score: \(score)"
                
                if card.isSelected
                {
                    button.select()
                }else if game.isSetCards[index] != nil
                {
                    button.deselect()
                }else
                {
                    button.noSelect()
                }
                
            }else
            {
                let cardAtributes = NSAttributedString(string: "")
                button.titleLabel?.sizeToFit()
                button.setAttributedTitle(cardAtributes, for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.noSelect()
            }
        }
    }
    
}


