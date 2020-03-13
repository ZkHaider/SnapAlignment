//
//  Drawing.ViewModel.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public final class DrawingViewModel {
    
    // MARK: - Attributes
    
    public var guideState: GuideState
    public var lastDragLocation: CGPoint = .zero
    public var debugMode: Bool = false
    
    // MARK: - Init
    
    public init(guideState: GuideState) {
        self.guideState = guideState
    }
    
    // MARK: - Shape Guides
    
    public func addShapeGuides(
        for shapeView: ShapeView,
        in superview: NSView)
    {
        
        // We want to set guides for this shape view
        // .top, .left, .right, .bottom, .centerX, .centerY
        let anchorPoints: [Anchor] = [.bottom, .left, .right, .right, .centerX, .centerY]
        for anchor in anchorPoints {
            
            // Get our anchor frame first
            let anchorFrame = anchor.getAnchorGuideFrame(
                in: superview.bounds,
                anchorWidth: 1.0
            )
            
            // Generate a guide
            let guide: Guide = .shape(
                GuideMetaInfo(
                    position: anchor.guideDirection == .horizontal ? anchorFrame.minY : anchorFrame.minX,
                    viewHash: shapeView.objectHash,
                    direction: anchor.guideDirection,
                    anchor: anchor,
                    guideColor: NSColor.red
                )
            )
            
            // Add and set our guide
            self.guideState.addShapeGuide(
                guide,
                for: shapeView.objectHash
            )
        }
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
    
    public func startingDrag(
        for shapeView: ShapeView,
        in superview: NSView,
        event: NSEvent)
    {
        
        self.lastDragLocation = superview.convert(event.locationInWindow, to: nil)
        #if DEBUG
        if (debugMode) {
            print("""
                👇 Start Drag at: \(self.lastDragLocation)
            """)
        }
        #endif
    }
    
    
    public func dragging(
        for shapeView: ShapeView,
        in superview: NSView,
        event: NSEvent)
    {
        
        // Find closest guides first
        guard
           let guideResult = snap(
               shapeView: shapeView,
               superview: superview
           )
           else { return }
        
        let deltaX = event.deltaX
        let deltaY = event.deltaY
        
        let newDragLocation = superview.convert(event.locationInWindow, to: nil)
        var origin = shapeView.frame.origin
        origin.x += (-self.lastDragLocation.x + newDragLocation.x)
        origin.y += (-self.lastDragLocation.y + newDragLocation.y)
        shapeView.setFrameOrigin(origin)
        self.lastDragLocation = newDragLocation
        
        #if DEBUG
        if (debugMode) {
            print("""
            👉 Drag Location: \(newDragLocation), Origin: \(origin)
            """)
        }
        #endif
        
        let movingLeft = deltaX < -1
        let movingRight = deltaX > 1
        let movingUp = deltaY < -1
        let movingDown = deltaY > 1
        
        // Set horizontal guide if below delta
        if (!movingLeft && !movingRight && guideResult.nearestHorizontalGuide != nil) {
            shapeView.frame.origin.y = guideResult.snapRect.origin.y
        }
        
        // Set vertical guide if below delta
        if (!movingUp && !movingDown && guideResult.nearestVerticalGuide != nil) {
            shapeView.frame.origin.x = guideResult.snapRect.origin.x
        }
        
    }
    
    public func endingDrag(
        for shapeView: ShapeView,
        in superview: NSView,
        event: NSEvent)
    {
        
        // We've ended dragging so update our dragged view guide
        // 1. Get all guides for shape view
        // 2. Generate new guide rect
        // 3. Update in State
        
        // 1.
        let shapeViewGuides = self.guideState.shapeGuides.filter {
            $0.viewIdentifier == shapeView.objectHash
        }
        
        shapeViewGuides.forEach { guide in
            
            var updatedGuide: Guide = guide
            
            // 2.
            let guideRect = guide.rect(
                for: shapeView.frame,
                inside: superview.bounds
            )
         
            
            switch guide.direction {
            case .vertical:
                updatedGuide.updatePosition(guideRect.minY)
            case .horizontal:
                updatedGuide.updatePosition(guideRect.minX)
            }
            
            // 3. Update
            update(guide)
        }
    }
    
}

extension DrawingViewModel {
    
    /// Snaps nearest corner or centre point to the nearest guide if within threshold.
    /// @param rect -- is the rect of the view that needs to be snapped to a guide
    /// @param superViewBounds -- is used to calculate the guide rect
    public func snap(
        shapeView view: ShapeView,
        superview: NSView) -> GuideResult? {
        
        let rect = view.frame
                
        // Initial rect
        var snapRect = rect
        
        // Get horizontal and vertical guides not pertaining to this view
        
        let horizontalGuides = self.guideState.allGuides.filter {
            $0.direction == .horizontal && $0.viewIdentifier != view.objectHash
        }
        let verticalGuides = self.guideState.allGuides.filter {
            $0.direction == .vertical && $0.viewIdentifier != view.objectHash
        }
        
        // >> Check Min and Max For Vertical Guide <<
        
        var _verticalGuide: Guide? = nil
        if let (verticalGuide, guideRect) = nearestVerticalGuide(
            for: rect.minX,
            shapeRect: rect,
            superview: superview,
            with: verticalGuides)
        {
            snapRect.origin.x = guideRect.minX
            _verticalGuide = verticalGuide
        } else if let (verticalGuide, guideRect) = nearestVerticalGuide(
            for: rect.maxX,
            shapeRect: rect,
            superview: superview,
            with: verticalGuides) {
            snapRect.origin.x = guideRect.minX - snapRect.size.width
            _verticalGuide = verticalGuide
        }
        
        // >> Check Min and Max For Horizontal Guide <<
        
        var _horizontalGuide: Guide? = nil
        if let (horizontalGuide, guideRect) = nearestHorizontalGuide(
            for: rect.minY,
            shapeRect: rect,
            superview: superview,
            with: horizontalGuides)
        {
            snapRect.origin.y = guideRect.minY
            _horizontalGuide = horizontalGuide
        } else if let (horizontalGuide, guideRect) = nearestHorizontalGuide(
            for: rect.maxY,
            shapeRect: rect,
            superview: superview,
            with: horizontalGuides) {
            snapRect.origin.y = guideRect.minY - snapRect.size.height
            _horizontalGuide = horizontalGuide
        }
        
        return GuideResult(
            nearestVerticalGuide: _verticalGuide,
            nearestHorizontalGuide: _horizontalGuide,
            snapRect: snapRect
        )
    }
    
    fileprivate func nearestVerticalGuide(
        for position: CGFloat,
        shapeRect rect: CGRect,
        superview: NSView,
        with verticalGuides: Set<Guide>) -> (Guide, CGRect)? {
        
        // Find closes vertical guide first
        var distance = CGFloat.greatestFiniteMagnitude
        var upperBoundDistance: CGFloat = 10000.0
        
        var nearestGuideWithRect: (Guide, CGRect)? = nil
        for guide in verticalGuides {
            
            // If its a canvas guide our rect will be superview bounds
            // else the shape view rect
            let guideRect: CGRect
            if case .canvas = guide {
                guideRect = guide.rect(
                    for: superview.bounds,
                    inside: superview.bounds
                )
            } else {
                
                if let relativeShapeView = superview.subviews
                    .first(where: { $0.objectHash == guide.viewIdentifier })
                {
                    guideRect = guide.rect(
                        for: relativeShapeView.frame,
                        inside: superview.bounds
                    )
                } else {
                    continue
                }
                
            }
            
            distance = abs(position - guideRect.minX)
            if (distance < guideState.guideThreshold && distance < upperBoundDistance) {
                upperBoundDistance = distance
                nearestGuideWithRect = (guide, guideRect)
            }
        }
        return nearestGuideWithRect
    }
    
    fileprivate func nearestHorizontalGuide(
        for position: CGFloat,
        shapeRect rect: CGRect,
        superview: NSView,
        with horizontalGuides: Set<Guide>) -> (Guide, CGRect)? {
        
        // Find closes vertical guide first
        var distance = CGFloat.greatestFiniteMagnitude
        var upperBoundDistance: CGFloat = 10000.0
        
        var nearestGuideWithRect: (Guide, CGRect)? = nil
        for guide in horizontalGuides {
            
            // If its a canvas guide our rect will be superview bounds
            // else the shape view rect
            let guideRect: CGRect
            if case .canvas = guide {
                guideRect = guide.rect(
                    for: superview.bounds,
                    inside: superview.bounds
                )
            } else {
                
                if let relativeShapeView = superview.subviews
                    .first(where: { $0.objectHash == guide.viewIdentifier })
                {
                    guideRect = guide.rect(
                        for: relativeShapeView.frame,
                        inside: superview.bounds
                    )
                } else {
                    continue
                }
            }
            
            distance = abs(position - guideRect.minY)
            if (distance < guideState.guideThreshold && distance < upperBoundDistance) {
                upperBoundDistance = distance
                nearestGuideWithRect = (guide, guideRect)
            }
        }
        return nearestGuideWithRect
    }
    
}
