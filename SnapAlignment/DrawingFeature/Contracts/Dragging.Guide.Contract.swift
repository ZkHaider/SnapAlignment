//
//  Dragging.Guide.Contract.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/12/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public protocol DraggingGuideContract: class {
    func startDrag(
        _ view: ShapeView,
        in superview: NSView,
        event: NSEvent
    )
    func didDrag(
        _ view: ShapeView,
        in superview: NSView,
        event: NSEvent
    )
    func endedDrag(
        _ view: ShapeView,
        in superview: NSView,
        event: NSEvent
    )
}
