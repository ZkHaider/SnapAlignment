//
//  Dragging.View.Contract.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public protocol DraggingViewContract: class {
    func startedDrag(
        at point: CGPoint,
        for view: ShapeView
    )
    func dragging(
        at origin: CGPoint,
        with lastDragLocation: CGPoint,
        for view: ShapeView
    )
    func endDrag(
        at point: CGPoint,
        for view: ShapeView
    )
}
