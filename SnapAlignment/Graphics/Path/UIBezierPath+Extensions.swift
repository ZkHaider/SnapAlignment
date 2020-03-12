//
//  UIBezierPath+Extensions.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

extension Set where Element == Path {
    
    public func bezierPath() -> NSBezierPath {
        let bezierPath = NSBezierPath()
        for point in self {
            switch point {
            case .arc(let arc):
                bezierPath.appendArc(
                    withCenter: arc.center,
                    radius: arc.radius,
                    startAngle: arc.startAngle.degrees,
                    endAngle: arc.endAngle.degrees
                )
            case .square(let square):
                bezierPath.appendRect(
                    NSRect(
                        x: square.origin.x,
                        y: square.origin.y,
                        width: square.radius * 2.0,
                        height: square.radius * 2.0
                    )
                )
            case .line(let line):
                bezierPath.move(to: line.start)
                bezierPath.line(to: line.end)
            }
        }
        bezierPath.close()
        return bezierPath
    }
    
}
