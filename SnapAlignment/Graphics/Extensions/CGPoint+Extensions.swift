//
//  CGPoint+Extensions.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

extension CGPoint {
    
    func distance(to point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        let sum = pow(dx, 2) + pow(dy, 2)
        let sqrt = sqrtf(Float(sum))
        return CGFloat(sqrt)
    }
    
    func intDistance(to point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        let sum = pow(dx, 2) + pow(dy, 2)
        let sqrt = sqrtf(Float(sum))
        return CGFloat(sqrt)
    }
    
}
