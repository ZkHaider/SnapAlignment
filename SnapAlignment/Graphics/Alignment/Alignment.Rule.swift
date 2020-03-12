//
//  Alignment.Rule.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

// MARK: - Alignment Rule

public enum AlignmentRule {
    case horizontal
    case vertical
    case center
}

// MARK: - Alignable type

public protocol Alignable {}

// MARK: - Phantom Type Alignments

public enum TopLeft: Alignable {}
public enum CenterTop: Alignable {}
public enum TopRight: Alignable {}
public enum CenterLeft: Alignable {}
public enum Center: Alignable {}
public enum CenterRight: Alignable {}
public enum BottomLeft: Alignable {}
public enum CenterBottom: Alignable {}
public enum BottomRight: Alignable {}

public struct Aligning<U: Alignable, V: Alignable> {
    let align: (ShapeView, ShapeView) -> SnapPointPair?
}

/// Top Left to Top Right of other view
extension Aligning where U == TopLeft, V == TopRight {
    
    public static let aligner: Aligning = {
        return Aligning { view1, view2 in
            
            guard
                let leftSnapPointView = view1.snapPointViews
                    .first(where: { $0.snapPosition.isLeftEdge }),
                let rightSnapPointView = view2.snapPointViews
                    .first(where: { $0.snapPosition.isRightEdge })
                else {
                    return nil
            }
            
            let leftCenter = leftSnapPointView.frame.center
            guard
                let rightCenter = rightSnapPointView.relativeCenter(to: leftSnapPointView)
                else { return nil }
            
            return SnapPointPair(
                lhsSnap: leftSnapPointView,
                rhsSnap: rightSnapPointView,
                distance: abs(leftCenter.x - rightCenter.x),
                alignmentRule: .horizontal
            )
        }
    }()
    
}

/// Top Right to Top Left of other view
extension Aligning where U == TopRight, V == TopLeft {
    
    public static let aligner: Aligning = {
        return Aligning { view1, view2 in
            
            guard
                let rightSnapPointView = view1.snapPointViews
                    .first(where: { $0.snapPosition.isRightEdge }),
                let leftSnapPointView = view2.snapPointViews
                    .first(where: { $0.snapPosition.isLeftEdge })
                else { return nil }
            
            let rightCenter = rightSnapPointView.frame.center
            guard
                let leftCenter = leftSnapPointView.relativeCenter(to: rightSnapPointView)
                else { return nil }
                        
            return SnapPointPair(
                lhsSnap: leftSnapPointView,
                rhsSnap: rightSnapPointView,
                distance: abs(leftCenter.x - rightCenter.x),
                alignmentRule: .horizontal
            )
        }
    }()
    
}

/// Top Left to Top Left of other view
extension Aligning where U == TopLeft, V == TopLeft {
    
    public static let aligner: Aligning = {
        return Aligning { view1, view2 in
            
            guard
                let leftSnapPointView1 = view1.snapPointViews
                    .first(where: { $0.snapPosition.isLeftEdge }),
                let leftSnapPointView2 = view2.snapPointViews
                    .first(where: { $0.snapPosition.isLeftEdge })
                else { return nil }
            
            let leftCenter1 = leftSnapPointView1.frame.center
            guard
                let leftCenter2 = leftSnapPointView2.relativeCenter(to: leftSnapPointView1)
                else { return nil }
            
            return SnapPointPair(
                lhsSnap: leftSnapPointView1,
                rhsSnap: leftSnapPointView2,
                distance: abs(leftCenter1.x - leftCenter2.x),
                alignmentRule: .horizontal
            )
        }
    }()
    
}

extension Aligning where U == TopRight, V == TopRight {
    
    public static let aligner: Aligning = {
        return Aligning { view1, view2 in
            
            guard
                let rightSnapPointView1 = view1.snapPointViews
                    .first(where: { $0.snapPosition.isRightEdge }),
                let rightSnapPointView2 = view2.snapPointViews
                    .first(where: { $0.snapPosition.isRightEdge })
                else { return nil }
            
            let rightCenter1 = rightSnapPointView1.frame.center
            guard
                let rightCenter2 = rightSnapPointView2.relativeCenter(to: rightSnapPointView1)
                else { return nil }
                        
            return SnapPointPair(
                lhsSnap: rightSnapPointView1,
                rhsSnap: rightSnapPointView2,
                distance: abs(rightCenter1.x - rightCenter2.x),
                alignmentRule: .horizontal
            )
        }
    }()
    
}
