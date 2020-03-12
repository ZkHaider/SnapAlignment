//
//  Snap.Point.Pair.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import CoreGraphics

public struct SnapPointPair {
    
    /// Copy on write semantics
    fileprivate let lhsSnapPoint: Box<SnapPointView>
    fileprivate let rhsSnapPoint: Box<SnapPointView>
    
    public var lhsSnap: SnapPointView {
        return self.lhsSnapPoint.value
    }
    
    public var rhsSnap: SnapPointView {
        return self.rhsSnapPoint.value
    }
    
    public let distance: CGFloat
    public let alignmentRule: AlignmentRule
    
    // MARK: - Init
    
    init(
        lhsSnap: SnapPointView,
        rhsSnap: SnapPointView,
        distance: CGFloat,
        alignmentRule: AlignmentRule)
    {
        self.lhsSnapPoint = Box(value: lhsSnap)
        self.rhsSnapPoint = Box(value: rhsSnap)
        self.distance = distance
        self.alignmentRule = alignmentRule
    }
    
    
    
}
