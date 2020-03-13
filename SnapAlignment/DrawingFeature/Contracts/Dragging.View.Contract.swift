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
        for view: ShapeView,
        in superview: NSView,
        event: NSEvent
    )
    func dragging(
        for view: ShapeView,
        in superview: NSView,
        event: NSEvent
    )
    func endDrag(
        for view: ShapeView,
        in superview: NSView,
        event: NSEvent
    )
}
