//
//  maskGrid.swift
//  textRecognition
//
//  Created by Burak Gunerhanal on 29/03/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

import Foundation
import UIKit

class maskGrid: UIView {

override func draw(_ rect: CGRect) {
    // Drawing code
    let path = UIBezierPath()
    UIColor.black.setStroke()
    
    path.move(to: CGPoint(x: 80, y:50))
    path.addLine(to: CGPoint(x:140, y:150))
    path.addLine(to: CGPoint(x:10, y:150))
    path.close()
    path.stroke()
    }
}
