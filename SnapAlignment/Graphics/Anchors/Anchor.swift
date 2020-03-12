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
        for bounds: NSRect,
        anchorWidth: CGFloat) -> CGRect {
         
         let superviewBounds = bounds
         
         switch self {
         case .top:
             return CGRect(
                 x: superviewBounds.minX,
                 y: superviewBounds.minY,
                 width: superviewBounds.width,
                 height: anchorWidth
             )
         case .left:
             return CGRect(
                 x: superviewBounds.minX,
                 y: superviewBounds.minY,
                 width: anchorWidth,
                 height: superviewBounds.height
             )
         case .right:
             return CGRect(
                 x: superviewBounds.maxX - anchorWidth,
                 y: superviewBounds.minY,
                 width: anchorWidth,
                 height: superviewBounds.height
             )
         case .centerX:
             return CGRect(
                 x: superviewBounds.midX - (anchorWidth / 2.0),
                 y: superviewBounds.minY,
                 width: anchorWidth,
                 height: superviewBounds.height
             )
         case .centerY:
             return CGRect(
                 x: superviewBounds.minX,
                 y: superviewBounds.midY - (anchorWidth / 2.0),
                 width: superviewBounds.width,
                 height: anchorWidth
             )
         case .bottom:
             return CGRect(
                 x: superviewBounds.minX,
                 y: superviewBounds.maxY - anchorWidth,
                 width: superviewBounds.width,
                 height: anchorWidth
             )
         }
     }
    
}
