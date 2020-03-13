//
//  Guide.Rule.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public enum Guide {
    
    // MARK: - Cases
    
    case canvas(GuideMetaInfo)
    case shape(GuideMetaInfo)
    
    public var position: CGFloat {
        switch self {
        case .canvas(let meta): return meta.position
        case .shape(let meta): return meta.position
        }
    }
    
    public var anchor: Anchor {
        switch self {
        case .canvas(let meta): return meta.anchor
        case .shape(let meta): return meta.anchor
        }
    }
    
    public var meta: GuideMetaInfo {
        switch self {
        case .canvas(let meta): return meta
        case .shape(let meta): return meta
        }
    }
    
    public var color: NSColor {
        switch self {
        case .canvas(let meta): return meta.guideColor
        case .shape(let meta): return meta.guideColor
        }
    }
    
    public var viewIdentifier: Int {
        switch self {
        case .canvas(let meta): return meta.viewHash
        case .shape(let meta): return meta.viewHash
        }
    }
    
    public var direction: GuideDirection {
        switch self {
        case .canvas(let meta): return meta.direction
        case .shape(let meta): return meta.direction
        }
    }
    
    public mutating func updateMetaInfo(_ meta: GuideMetaInfo) {
        switch self {
        case .canvas:
            self = .canvas(meta)
        case .shape:
            self = .shape(meta)
        }
    }
    
    public mutating func updatePosition(_ position: CGFloat) {
        switch self {
        case .canvas(let meta):
            self = .canvas(
                GuideMetaInfo(
                    position: position,
                    viewHash: meta.viewHash,
                    direction: meta.direction,
                    anchor: meta.anchor,
                    guideColor: meta.guideColor
                )
            )
        case .shape(let meta):
            self = .shape(
                GuideMetaInfo(
                    position: position,
                    viewHash: meta.viewHash,
                    direction: meta.direction,
                    anchor: meta.anchor,
                    guideColor: meta.guideColor
                )
            )
        }
    }
    
}


extension Guide: Equatable {
    
    public static func ==(lhs: Guide,
                          rhs: Guide) -> Bool
    {
        switch lhs {
        case .canvas(let lhsMeta):
            switch rhs {
            case .canvas(let rhsMeta): return lhsMeta == rhsMeta
            default: return false
            }
        case .shape(let lhsMeta):
            switch rhs {
            case .shape(let rhsMeta): return lhsMeta == rhsMeta
            default: return false
            }
        }
    }
    
}

extension Guide: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.color)
        hasher.combine(self.direction)
        hasher.combine(self.position)
        hasher.combine(self.anchor)
        hasher.combine(self.viewIdentifier)
    }
    
}

extension Guide {
    
    // Get the guide rect relative to the rect that this guide is in.
    public func rect(
        for rect: CGRect,
        inside superviewBounds: CGRect) -> CGRect
    {
        let anchorFrame = meta.anchor.getAnchorGuideFrame(
            in: rect,
            anchorWidth: 1.0
        )
        
        return anchorFrame
    }
    
}
