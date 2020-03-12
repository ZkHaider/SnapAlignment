//
//  Drawing.ViewModel.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public final class DrawingViewModel {
    
    // MARK: - Attributes
    
    public var guideState: GuideState
    
    // MARK: - Init
    
    public init(guideState: GuideState) {
        self.guideState = guideState
    }
    
    // MARK: - Updating
    
    public func update(_ guide: Guide) {
        if let keyValue = self.guideState.canvasGuideCache.first(where: { $0.value == guide }) {
            self.guideState.canvasGuideCache[keyValue.key] = guide
        }
        if let keyValue = self.guideState.shapeGuideCache.first(where: { $0.value.contains(guide) }) {
            if (keyValue.value.contains(guide)) {
                var guides = keyValue.value
                guides.update(with: guide)
                self.guideState.shapeGuideCache[keyValue.key] = guides
            }
        }
    }
    
}

extension DrawingViewModel: Equatable {
    
    public static func ==(lhs: DrawingViewModel,
                          rhs: DrawingViewModel) -> Bool {
        if lhs.guideState != rhs.guideState {
            return false
        }
        return true 
    }
    
}

extension DrawingViewModel {
    
    /// Snaps nearest corner or centre point to the nearest guide if within threshold.
    /// @param rect -- is the rect of the view that needs to be snapped to a guide
    /// @param superViewBounds -- is used to calculate the guide rect
    public func snap(
        viewRect rect: CGRect,
        superViewBounds: CGRect) -> CGRect? {
        
        // Initial rect
        var snapRect = rect
        
        let horizontalGuides = self.guideState.allGuides.filter {
            $0.direction == .horizontal
        }
        let verticalGuides = self.guideState.allGuides
            .filter { $0.direction == .vertical }
        
        // >> Check Min and Max For Vertical Guide <<
        
        if let verticalGuide = nearestVerticalGuide(
            for: rect.minX,
            in: superViewBounds,
            with: verticalGuides)
        {
            snapRect.origin.x = verticalGuide.rect(inside: rect).minX
        } else if let verticalGuide = nearestVerticalGuide(
            for: rect.maxX,
            in: superViewBounds,
            with: verticalGuides) {
            snapRect.origin.x = verticalGuide.rect(inside: rect).minX - snapRect.size.width
        }
        
        // >> Check Min and Max For Horizontal Guide <<
        
        if let horizontalGuide = nearestHorizontalGuide(
            for: rect.minY,
            in: superViewBounds,
            with: horizontalGuides)
        {
            snapRect.origin.y = horizontalGuide.rect(inside: rect).minY
        } else if let verticalGuide = nearestHorizontalGuide(
            for: rect.maxY,
            in: superViewBounds,
            with: horizontalGuides) {
            snapRect.origin.y = verticalGuide.rect(inside: rect).minY - snapRect.size.height
        }
        
        return snapRect
    }
    
    fileprivate func nearestVerticalGuide(
        for position: CGFloat,
        in rect: CGRect,
        with verticalGuides: Set<Guide>) -> Guide? {
        
        // Find closes vertical guide first
        var distance = CGFloat.greatestFiniteMagnitude
        var upperBoundDistance: CGFloat = 10000.0
        
        var nearestVeriticalGuide: Guide? = nil
        for guide in verticalGuides {
            let guideRect = guide.rect(inside: rect)
            distance = abs(position - guideRect.minX)
            if (distance < guideState.guideThreshold && distance < upperBoundDistance) {
                upperBoundDistance = distance
                nearestVeriticalGuide = guide
            }
        }
        return nearestVeriticalGuide
    }
    
    fileprivate func nearestHorizontalGuide(
        for position: CGFloat,
        in rect: CGRect,
        with horizontalGuides: Set<Guide>) -> Guide? {
        
        // Find closes vertical guide first
        var distance = CGFloat.greatestFiniteMagnitude
        var upperBoundDistance: CGFloat = 10000.0
        
        var nearestHorizontalGuide: Guide? = nil
        for guide in horizontalGuides {
            let guideRect = guide.rect(inside: rect)
            distance = abs(position - guideRect.minY)
            if (distance < guideState.guideThreshold && distance < upperBoundDistance) {
                upperBoundDistance = distance
                nearestHorizontalGuide = guide
            }
        }
        return nearestHorizontalGuide
    }
    
}
