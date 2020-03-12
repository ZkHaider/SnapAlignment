//
//  Circle.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public struct Circle {
    var center: CGPoint
    var radius: CGFloat
}

extension Circle: Drawable {
    
    public var paths: Set<Path> {
        return [
            .arc(
                Path.Arc(
                    center: center,
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: .pi * 2
                )
            )
        ]
    }
    
}
