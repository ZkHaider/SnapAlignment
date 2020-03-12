//
//  Square.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public struct Square {
    var origin: CGPoint
    var radius: CGFloat
}

extension Square: Drawable {
    
    public var paths: Set<Path> {
        return [
            .square(
                Path.Square(
                    origin: self.origin,
                    radius: self.radius
                )
            )
        ]
    }
    
}
