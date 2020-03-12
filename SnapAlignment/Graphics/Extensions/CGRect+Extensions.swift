//
//  CGRect+Extensions.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

extension CGRect {
    
    public var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
}
