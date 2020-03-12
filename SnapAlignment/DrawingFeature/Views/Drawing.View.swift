//
//  View.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

final class DrawingView: NSView {
    
    // MARK: - Views
    
    public var canvasGuideViews: [NSView] = []
    
    let topAnchorView: AnchorView = {
        return AnchorView(anchor: .top)
    }()
    
    let leftAnchorView: AnchorView = {
        return AnchorView(anchor: .left)
    }()
    
    let rightAnchorView: AnchorView = {
        return AnchorView(anchor: .right)
    }()
    
    let centerXAnchorView: AnchorView = {
        return AnchorView(anchor: .centerX)
    }()
    
    let centerYAnchorView: AnchorView = {
        return AnchorView(anchor: .centerY)
    }()
    
    let bottomAnchorView: AnchorView = {
        return AnchorView(anchor: .bottom)
    }()
    
    var anchorViews: [AnchorView] {
        return [
            topAnchorView,
            leftAnchorView,
            rightAnchorView,
            centerXAnchorView,
            centerYAnchorView,
            bottomAnchorView
        ]
    }
    
    var shapeViews: [ShapeView] {
        return self.subviews.compactMap { $0 as? ShapeView }
    }
    
    func otherShapeViews(
        relativeTo view: ShapeView) -> [ShapeView]
    {
        return self.shapeViews.filter { $0 != view }
    }
    
    // MARK: - Attributes 
    
    override var isFlipped: Bool {
        return true
    }
    
    // MARK: - Delegates
    
    public weak var draggingGuideDelegate: DraggingGuideContract? = nil
    
    // MARK: - Init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layout() {
        super.layout()
        anchorViews.forEach({ $0.layout() })
    }
    
    // MARK: - ShapeViews
    
    func addShapeView(_ shapeView: ShapeView) {
        shapeView.draggingDelegate = self
        self.addSubview(shapeView)
    }
    
}

extension DrawingView: DraggingViewContract {
    
    func startedDrag(
        at point: CGPoint,
        for view: ShapeView)
    {
        // Mouse down event -- ignore any anchor positions for this...
        // bad UX to show immediately
    }
    
    func dragging(
        at origin: CGPoint,
        with lastDragLocation: CGPoint,
        for view: ShapeView)
    {
        // Dragging here determine logic for anchor position
        anchorViews.forEach { [weak self] in
            guard let _ = self else { return }
            if (view.frame.intersects($0.frame)) {
                $0.alphaValue = 1.0
            } else {
                $0.alphaValue = 0.0
            }
        }
        self.draggingGuideDelegate?.didDrag(view)
    }
    
    func endDrag(
        at point: CGPoint,
        for view: ShapeView) {
        
        // Snap to if we are within threshold
        anchorViews.forEach {
            $0.alphaValue = 0.0
        }
    }
    
}

extension DrawingView {
    fileprivate func initialize() {
        func addSubviews() {
            anchorViews.forEach({
                $0.alphaValue = 0.0
                self.addSubview($0)
            })
        }
        func prepareViews() {
            self.setValue(NSColor.white, forKey: "backgroundColor")
            self.wantsLayer = true
            self.canDrawConcurrently = true 
        }
        addSubviews()
        prepareViews()
    }
}
