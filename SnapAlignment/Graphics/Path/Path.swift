//
//  Path.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public enum Path: Hashable {
    
    public struct Arc: Hashable {
        var center: CGPoint
        var radius: CGFloat
        var startAngle: CGFloat
        var endAngle: CGFloat
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.center.x)
            hasher.combine(self.center.y)
            hasher.combine(self.startAngle)
            hasher.combine(self.endAngle)
        }
    }
    
    public struct Line: Hashable {
        var start: CGPoint
        var end: CGPoint
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.start.x)
            hasher.combine(self.start.y)
            hasher.combine(self.end.x)
            hasher.combine(self.end.y)
        }
    }
    
    public struct Square: Hashable {
        var origin: CGPoint
        var radius: CGFloat
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.origin.x)
            hasher.combine(self.origin.y)
            hasher.combine(self.radius)
        }
    }
    
    case arc(Arc)
    case line(Line)
    case square(Square)
    
}

extension Path {
    
    public static func circle(
        at center: CGPoint,
        radius: CGFloat) -> Path
    {
        return .arc(
            Path.Arc(
                center: center,
                radius: radius,
                startAngle: 0.0,
                endAngle: .pi * 2.0
            )
        )
    }
    
}
