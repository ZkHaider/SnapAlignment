//
//  Guide.Layer.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public final class GuideState {
    
    // MARK: - Attributes
    
    // A single shape can have multiple guides
    public var shapeGuideCache: [ShapeView.ShapeGuideIdentifier: Set<Guide>]
    
    // Our canvas has a 1 guide per 1 view
    public var canvasGuideCache: [DrawingViewController.CanvasGuideIdentifier: Guide]
    
    public var shapeGuides: Set<Guide> {
        return shapeGuideCache.values
            .reduce(
                into: Set<Guide>(),
                { $0.formUnion($1) }
            )
    }
    
    public var canvasGuides: Set<Guide> {
        return Set(canvasGuideCache.values)
    }
    
    public var allGuides: Set<Guide> {
        return canvasGuides.union(shapeGuides)
    }
    
    /// Threshold until a view snaps -- 6 px
    public let guideThreshold: CGFloat
    
    // MARK: - Init
    
    public init(
        shapeGuideCache: [ShapeView.ShapeGuideIdentifier: Set<Guide>] = [:],
        canvasGuideCache: [DrawingViewController.CanvasGuideIdentifier: Guide] = [:],
        guideThreshold: CGFloat = 6.0)
    {
        self.shapeGuideCache = shapeGuideCache
        self.canvasGuideCache = canvasGuideCache
        self.guideThreshold = guideThreshold
    }
    
}

extension GuideState {

    public func addShapeGuide(
        _ guide: Guide,
        for identifier: ShapeView.ShapeGuideIdentifier)
    {
        guard
            var guides = self.shapeGuideCache[identifier],
            !guides.contains(guide)
            else {
                
                // Create a new set
                let guides = Set<Guide>(arrayLiteral: guide)
                self.shapeGuideCache[identifier] = guides
                return
        }
        guides.insert(guide)
        self.shapeGuideCache[identifier] = guides
    }
    
    public func addCanvasGuide(
        _ guide: Guide,
        for identifier: DrawingViewController.CanvasGuideIdentifier)
    {
        // Add or update.
        self.canvasGuideCache[identifier] = guide
    }
    
}

extension GuideState: Equatable {
    
    public static func ==(lhs: GuideState,
                          rhs: GuideState) -> Bool
    {
        if lhs.shapeGuideCache != rhs.shapeGuideCache {
            return false
        }
        if lhs.canvasGuideCache != rhs.canvasGuideCache {
            return false
        }
        if lhs.guideThreshold != rhs.guideThreshold {
            return false 
        }
        return true
    }
    
}
