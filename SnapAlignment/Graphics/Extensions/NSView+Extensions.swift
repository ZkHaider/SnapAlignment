//
//  NSView+Extensions.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

extension NSView {
    
    /// The SnapPointView is inside a ShapeView which has a parent view
    /// the parent view encapsulates all adjacent shape views so use that view
    /// to convert the center point from the current view parent shape view
    /// coordinate space.
    public func relativeCenter(
        to view: NSView) -> CGPoint?
    {
        // We want the shape views superviews 
        guard
            let currentViewShapeView = self.superview,
            let currentShapeViewSuperView = self.superview?.superview,
            let otherShapeViewSuperView = view.superview?.superview
            else { return self.frame.center }
        
        // Check to see if superviews match
        guard
            currentShapeViewSuperView == otherShapeViewSuperView
            else {
                
                // If they don't match use other views superview
                return otherShapeViewSuperView.convert(
                    self.frame.center,
                    from: nil
                )
        }
        return currentShapeViewSuperView.convert(self.frame.center, from: currentViewShapeView)
    }
    
    public var objectHash: Int {
        return ObjectIdentifier(self).hashValue
    }
    
}
