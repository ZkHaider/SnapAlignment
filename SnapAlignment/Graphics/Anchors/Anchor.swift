//
//  Anchor.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public enum Anchor {
    case top
    case centerX
    case centerY
    case left
    case right
    case bottom
}

extension Anchor: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        switch self {
        case .top:
            return "top"
        case .centerX:
            return "centerX"
        case .centerY:
            return "centerY"
        case .left:
            return "left"
        case .right:
            return "right"
        case .bottom:
            return "bottom"
        }
    }
    
    public var guideDirection: GuideDirection {
        switch self {
        case .top:
            return .horizontal
        case .centerX:
            return .horizontal
        case .centerY:
            return .vertical
        case .left:
            return .vertical
        case .right:
            return .vertical
        case .bottom:
            return .horizontal
        }
    }
    
}

extension Anchor {
    
    public func getAnchorGuideFrame(
        in rect: CGRect,
        anchorWidth: CGFloat) -> CGRect {
        
        switch self {
        case .top:
            return CGRect(
                x: rect.minX,
                y: rect.minY,
                width: rect.width,
                height: anchorWidth
            )
        case .left:
            return CGRect(
                x: rect.minX,
                y: rect.minY,
                width: anchorWidth,
                height: rect.height
            )
        case .right:
            return CGRect(
                x: rect.maxX - anchorWidth,
                y: rect.minY,
                width: anchorWidth,
                height: rect.height
            )
        case .centerX:
            return CGRect(
                x: rect.midX - (anchorWidth / 2.0),
                y: rect.minY,
                width: anchorWidth,
                height: rect.height
            )
        case .centerY:
            return CGRect(
                x: rect.minX,
                y: rect.midY - (anchorWidth / 2.0),
                width: rect.width,
                height: anchorWidth
            )
        case .bottom:
            return CGRect(
                x: rect.minX,
                y: rect.maxY - anchorWidth,
                width: rect.width,
                height: anchorWidth
            )
        }
    }
    
}
