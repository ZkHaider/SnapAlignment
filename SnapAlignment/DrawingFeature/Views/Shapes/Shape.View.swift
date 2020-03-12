//
//  Shape.View.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public final class ShapeView: NSControl {
    
    // MARK: - Definitions
    
    public typealias ShapeGuideIdentifier = Int 
    
    // MARK: - Layer
    
    private var shapeLayer: ShapeLayer {
        return self.layer as! ShapeLayer
    }
    
    override public var wantsDefaultClipping: Bool {
        return false
    }
    
    // MARK: - Views
    
    let topLeftSnapView: SnapPointView = {
        return SnapPointView(snapPosition: .topLeft)
    }()
    
    let centerTopSnapView: SnapPointView = {
        return SnapPointView(snapPosition: .centerTop)
    }()
    
    let topRightSnapView: SnapPointView = {
        return SnapPointView(snapPosition: .topRight)
    }()
    
    let centerLeftSnapView: SnapPointView = {
        return SnapPointView(snapPosition: .centerLeft)
    }()
    
    // Hide center snap point
    let centerSnapView: SnapPointView = {
        let snapPointView = SnapPointView(snapPosition: .center)
        snapPointView.alphaValue = 0.0
        return snapPointView
    }()
    
    let centerRightSnapView: SnapPointView = {
        return SnapPointView(snapPosition: .centerRight)
    }()
    
    let bottomLeftSnapView: SnapPointView = {
        return SnapPointView(snapPosition: .bottomLeft)
    }()
    
    let centerBottomSnapView: SnapPointView = {
        return SnapPointView(snapPosition: .centerBottom)
    }()
    
    let bottomRightSnapView: SnapPointView = {
        return SnapPointView(snapPosition: .bottomRight)
    }()
    
    var snapPointViews: [SnapPointView] {
        return [
            topLeftSnapView,
            centerTopSnapView,
            topRightSnapView,
            centerLeftSnapView,
            centerSnapView,
            centerRightSnapView,
            bottomLeftSnapView,
            centerBottomSnapView,
            bottomRightSnapView
        ]
    }
    
    var snapPointsWithoutCenter: [SnapPointView] {
        return [
            topLeftSnapView,
            centerTopSnapView,
            topRightSnapView,
            centerLeftSnapView,
            centerRightSnapView,
            bottomLeftSnapView,
            centerBottomSnapView,
            bottomRightSnapView
        ]    }
    
    // MARK: - Attributes
    
    var paths: Set<Path> = Set()
    var color: NSColor
    let debugMode: Bool
    var lastDragLocation: CGPoint = .zero
    
    // MARK: - Delegates
    
    weak var draggingDelegate: DraggingViewContract? = nil 
    
    // MARK: - Init
    
    init(paths: Set<Path>,
         color: NSColor = .red,
         debugMode: Bool = false) {
        self.paths = paths
        self.color = color
        self.debugMode = debugMode
        super.init(frame: paths.bezierPath().bounds)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override public func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        self.window?.makeFirstResponder(self)
    }
    
    override public var acceptsFirstResponder: Bool {
        return true
    }
    
    override public func becomeFirstResponder() -> Bool {
        // Enable snap point grid
        snapPointsWithoutCenter.forEach { $0.alphaValue = 1.0 }
        return super.becomeFirstResponder()
    }
    
    override public func resignFirstResponder() -> Bool {
        snapPointsWithoutCenter.forEach { $0.alphaValue = 0.0 }
        return super.resignFirstResponder()
    }
    
    override public func makeBackingLayer() -> CALayer {
        let shapeLayer = ShapeLayer(paths: self.paths, fillColor: self.color.cgColor)
        shapeLayer.delegate = self
        shapeLayer.needsDisplayOnBoundsChange = true 
        return shapeLayer
    }
    
    override public func layout() {
        super.layout()
        snapPointViews.forEach { $0.layout() }
    }
    
    // MARK: - Touch / Drag
    
    override public func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    
    override public func mouseDown(with event: NSEvent) {
        guard
            let superview = self.superview
            else { return }
        
        self.window?.makeFirstResponder(self)
        
        self.lastDragLocation = superview.convert(event.locationInWindow, to: nil)
        #if DEBUG
        if (debugMode) {
            print("""
                👇 Start Drag at: \(self.lastDragLocation)
            """)
        }
        #endif
        self.draggingDelegate?.startedDrag(at: self.lastDragLocation, for: self)
    }
    
    override public func mouseDragged(with event: NSEvent) {
        guard
            let superview = self.superview
            else { return }
        
        let newDragLocation = superview.convert(event.locationInWindow, to: nil)
        var origin = self.frame.origin
        origin.x += (-self.lastDragLocation.x + newDragLocation.x)
        origin.y += (-self.lastDragLocation.y + newDragLocation.y)
        self.setFrameOrigin(origin)
        self.lastDragLocation = newDragLocation
        
        #if DEBUG
        if (debugMode) {
            print("""
            👉 Drag Location: \(newDragLocation), Origin: \(origin)
            """)
        }
        #endif
        
        self.draggingDelegate?.dragging(at: origin, with: newDragLocation, for: self)
    }
    
    override public func mouseUp(with event: NSEvent) {
        self.draggingDelegate?.endDrag(at: self.lastDragLocation, for: self)
    }
    
}

extension ShapeView: CALayerDelegate {
    
}

extension ShapeView {
    fileprivate func initialize() {
        func addSubviews() {
            snapPointViews.forEach(self.addSubview)
        }
        func prepareViews() {
            self.wantsLayer = true
            self.canDrawConcurrently = true
            self.layerContentsRedrawPolicy = .onSetNeedsDisplay
            self.translatesAutoresizingMaskIntoConstraints = false
            
            // Shadow
            let shadow = NSShadow()
            self.shadow = shadow
            self.layer?.shadowOpacity = 0.8
            self.layer?.shadowOffset = CGSize(width: 0.0, height: -2.0)
            self.layer?.shadowRadius = 2.0
        }
        addSubviews()
        prepareViews()
    }
}
