//
//  DrawButtonView.swift
//  test
//
//  Created by apple on 12/06/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import UIKit

class DrawButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var cardToDraw: Card?
    {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    

    private func getNumber(for cardDraw: Card) -> Int
    {
        switch cardDraw.cardNumber {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3

        }
    }

    private func getColor(for cardDraw: Card) -> UIColor
    {
        
        switch cardDraw.cardColor {
        case .purple:
            return UIColor.purple
        case .green:
            return UIColor.green
        case.red:
            return UIColor.red

        }
    }
    private var drawableRect: CGRect
    {
        let drawableWidth = frame.size.width * 0.7
        let drawableHeight = frame.size.height * 0.9
        
        return CGRect(x: frame.size.width * 0.1,
                      y: frame.size.height * 0.05,
                      width: drawableWidth,
                      height: drawableHeight)
    }
    
    private var shapeHorizontalMargin: CGFloat
    {
        return drawableRect.width * 0.1
    }
    
    private var shapeVerticalMargin: CGFloat
    {
        return drawableRect.height * 0.1 + drawableRect.origin.y
    }
    
    private var shapeWidth: CGFloat
    {
        return (drawableRect.width - (2 * shapeHorizontalMargin)) / 3
    }
    
    private var shapeHeight: CGFloat
    {
        return drawableRect.height * 0.9
    }
    
    private var shapeCenter: CGPoint
    {
        return CGPoint(x: bounds.width / 2, y: bounds.width / 2)
    }
    
    var path: UIBezierPath?
    
    override func draw(_ rect: CGRect)
    {
        if cardToDraw != nil
        {
            
            let card = cardToDraw!
            
                let color = getColor(for: card)
                let number = getNumber(for: card)
                self.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                if card.isSelected
                {
                    self.select()
                }else if card.matching
                {
                    self.deselect()
                }else
                {
                    self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }
                
                switch card.cardSimbol
                {
                case .squiggle:
                    drawSquiggle(for: number)
                case .diamond:
                    drawDiamond(for: number)
                case .oval:
                    drawOval(for: number)

                }

                switch card.cardShading
                {
                case .full:
                    color.setFill()
                    path!.fill()
                case .empty:
                    color.setStroke()
                    path!.lineWidth = shapeWidth * 0.1
                    path!.stroke()
                case .stripped:
                    path!.lineWidth = shapeWidth * 0.1
                    color.setStroke()
                    path!.stroke()
                    path!.addClip()

                    let stripePath = UIBezierPath()
                    stripePath.lineWidth = shapeWidth * 0.05

                    var currentX: CGFloat = 0

                    while currentX < frame.size.width
                    {
                        stripePath.move(to: CGPoint(x: currentX, y: 0))
                        stripePath.addLine(to: CGPoint(x: currentX, y: frame.size.height))
                        currentX += stripePath.lineWidth * 3
                    }
                    color.setStroke()
                    stripePath.stroke()

                }
            
        }
        
    }
    
    func drawSquiggle(for number: Int)
    {
        let path = UIBezierPath()
        let allSquigglesWidth = CGFloat(number) * shapeWidth + CGFloat(number - 1) * shapeHorizontalMargin
        let beginX = (frame.size.width - allSquigglesWidth) / 2
        
        for i in 0..<number
        {
            let currentShapeX = beginX + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)
            let currentShapeY = shapeVerticalMargin
            let curveXOffset = shapeWidth * 0.35
            
            path.move(to: CGPoint(x: currentShapeX, y: currentShapeY))
            
            path.addCurve(to: CGPoint(x: currentShapeX, y: currentShapeY + shapeHeight - shapeHorizontalMargin),
                          controlPoint1: CGPoint(x: currentShapeX + curveXOffset, y: currentShapeY + shapeHeight / 3),
                          controlPoint2: CGPoint(x: currentShapeX - curveXOffset, y: currentShapeY + (shapeHeight / 3) * 2))
            
//            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth, y: currentShapeY + shapeHeight - shapeHorizontalMargin))
            path.addCurve(to: CGPoint(x: currentShapeX + shapeWidth, y: currentShapeY + shapeHeight - shapeHorizontalMargin), controlPoint1: CGPoint(x: currentShapeX + shapeWidth / 3, y: currentShapeY + shapeHeight - shapeHorizontalMargin / 2 ), controlPoint2: CGPoint(x: currentShapeX + (shapeWidth / 3) * 2, y: currentShapeY + shapeHeight - shapeHorizontalMargin))

            path.addCurve(to: CGPoint(x: currentShapeX + shapeWidth, y: currentShapeY),
                          controlPoint1: CGPoint(x: currentShapeX + shapeWidth - curveXOffset, y: currentShapeY + (shapeHeight / 3) * 2),
                          controlPoint2: CGPoint(x: currentShapeX + shapeWidth + curveXOffset, y: currentShapeY + shapeHeight / 3))

            path.addLine(to: CGPoint(x: currentShapeX, y: currentShapeY))
//            path.addCurve(to: CGPoint(x: currentShapeX, y: currentShapeY), controlPoint1: CGPoint(x: currentShapeX + shapeWidth / 3, y: currentShapeY - shapeHorizontalMargin / 2), controlPoint2: CGPoint(x: currentShapeX + (shapeWidth / 3) * 2, y: currentShapeY - shapeHorizontalMargin / 3))
//            path.addCurve(to: CGPoint(x: currentShapeX, y: currentShapeY), controlPoint1: CGPoint(x: currentShapeX + shapeWidth / 3, y: currentShapeY - shapeHorizontalMargin / 2 ), controlPoint2: CGPoint(x: currentShapeX + (shapeWidth / 3) * 2, y: currentShapeY - shapeHorizontalMargin))
        }
        self.path = path
    }
    
    func drawDiamond(for number: Int)
    {
        let path = UIBezierPath()
        let allDiamondWidth = CGFloat(number) * shapeWidth + CGFloat(number - 1) * shapeHorizontalMargin
        let beginX = (frame.size.width - allDiamondWidth) / 2
        
        for i in 0..<number
        {
            let currentShapeX = beginX + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)
            
            path.move(to: CGPoint(x: currentShapeX , y: shapeHeight / 2 + shapeHorizontalMargin / 2))
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth / 2, y: shapeHeight))
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth, y: shapeHeight / 2 + shapeHorizontalMargin / 2))
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth / 2, y: shapeHorizontalMargin))
            path.addLine(to: CGPoint(x: currentShapeX, y: shapeHeight / 2 + shapeHorizontalMargin / 2))
            
        }
        self.path = path
    }
    
    func drawOval(for number: Int)
    {
        let path = UIBezierPath()
        let allOvals = CGFloat(number) * shapeWidth + CGFloat(number - 1) * shapeHorizontalMargin
        let beginX = (frame.size.width - allOvals) / 2
        
        for i in 0..<number
        {
            let currentShapeX = beginX + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)
            
            path.append(UIBezierPath(roundedRect: CGRect(x: currentShapeX, y: shapeVerticalMargin * 1.25, width: shapeWidth, height: shapeHeight * 0.8), cornerRadius: shapeWidth))
        }
        self.path = path
    }
    
}
