//
//  Snap.Point.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public enum SnapPoint {
    
    // MARK: - Cases
    
    // Top points
    
    case topLeft
    case topRight
    case centerTop
    
    // Center Points
    
    case center
    case centerRight
    case centerLeft
    
    // Bottom Points
    case bottomLeft
    case centerBottom
    case bottomRight
    
    // MARK: - Accessory
    
    public var isLeftEdge: Bool {
        switch self {
        case .topLeft, .centerLeft, .bottomLeft: return true
        default: return false
        }
    }
    
    public var isTopEdge: Bool {
        switch self {
        case .topLeft, .centerTop, .topRight: return true
        default: return false
        }
    }
    
    public var isRightEdge: Bool {
        switch self {
        case .topRight, .centerRight, .bottomRight: return true
        default: return false
        }
    }
    
    public var isBottomEdge: Bool {
        switch self {
        case .bottomLeft, .centerBottom, .bottomRight: return true
        default: return false
        }
    }
    
    public func point(from frame: CGRect) -> CGPoint {
        switch self {
        case .topLeft:
            return CGPoint(x: frame.minX, y: frame.minY)
        case .topRight:
            return CGPoint(x: frame.minX, y: frame.maxY)
        case .centerTop:
            return CGPoint(x: frame.midX, y: frame.minY)
        case .center:
            return CGPoint(x: frame.midX, y: frame.midY)
        case .centerRight:
            return CGPoint(x: frame.maxX, y: frame.midY)
        case .centerLeft:
            return CGPoint(x: frame.minX, y: frame.midY)
        case .bottomLeft:
            return CGPoint(x: frame.minX, y: frame.maxY)
        case .centerBottom:
            return CGPoint(x: frame.midX, y: frame.maxY)
        case .bottomRight:
            return CGPoint(x: frame.maxX, y: frame.maxY)
        }
    }
    
}
