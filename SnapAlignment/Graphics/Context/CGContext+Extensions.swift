//
//  CGContext+Extensions.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

extension CGContext {
    
    func draw(_ arc: Path.Arc) {
        addArc(
            center: arc.center,
            radius: arc.radius,
            startAngle: arc.startAngle,
            endAngle: arc.endAngle,
            clockwise: true
        )
    }
    
    func draw(_ square: Path.Square) {
        addRect(
            CGRect(
                x: square.origin.x,
                y: square.origin.y,
                width: square.radius * 2.0,
                height: square.radius * 2.0
            )
        )
    }
    
    func draw(_ line: Path.Line,
              isFirstMove: Bool) {
        if isFirstMove {
            move(to: line.start)
        } else {
            addLine(to: line.start)
        }
        addLine(to: line.end)
    }
    
    func draw(_ paths: Set<Path>,
              withFill fillColor: CGColor = NSColor.red.cgColor,
              withStroke strokeColor: CGColor = NSColor.clear.cgColor) {
        var isFirstMove: Bool = true
        self.setFillColor(fillColor)
        self.setStrokeColor(strokeColor)
        for path in paths {
            switch path {
            case .line(let line):
                draw(line, isFirstMove: isFirstMove)
                isFirstMove = false
            case .square(let square):
                draw(square)
            case .arc(let arc):
                draw(arc)
            }
        }
        self.closePath()
        self.drawPath(using: .fillStroke)
    }
    
}
