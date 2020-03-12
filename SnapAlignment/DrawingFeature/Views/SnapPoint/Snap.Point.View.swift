//
//  Snap.Point.View.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public final class SnapPointView: NSView {
    
    public enum SnapType {
        case circular
        case square
    }
    
    // MARK: - Attributes
    
    let snapPosition: SnapPoint
    let radius: CGFloat
    let fillColor: NSColor
    let strokeColor: NSColor
    let snapType: SnapType
    
    // MARK: - Init
        
    public init(
        snapPosition: SnapPoint,
        radius: CGFloat = 3.0,
        fillColor: NSColor = NSColor.white,
        strokeColor: NSColor = NSColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 0.8),
        snapType: SnapType = .square) {
        self.snapPosition = snapPosition
        self.radius = radius
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.snapType = snapType
        super.init(frame: CGRect(
            x: 0.0,
            y: 0.0,
            width: radius * 2.0,
            height: radius * 2.0
        ))
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func layout() {
        super.layout()
        self.frame = getSnapPointFrame()
    }
    
    fileprivate func getSnapPointFrame() -> CGRect {
        
        guard
            let superview = self.superview
            else { return .zero }
        
        let superviewBounds = superview.bounds
                
        switch self.snapPosition {
        case .topLeft:
            return CGRect(
                x: superviewBounds.minX - radius,
                y: superviewBounds.minY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        case .topRight:
            return CGRect(
                x: superviewBounds.maxX - radius,
                y: superviewBounds.minY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        case .centerTop:
            return CGRect(
                x: superviewBounds.midX - radius,
                y: superviewBounds.minY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        case .center:
            return CGRect(
                x: superviewBounds.midX - radius,
                y: superviewBounds.midY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        case .centerRight:
            return CGRect(
                x: superviewBounds.maxX - radius,
                y: superviewBounds.midY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        case .centerLeft:
            return CGRect(
                x: superviewBounds.minX - radius,
                y: superviewBounds.midY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        case .bottomLeft:
            return CGRect(
                x: superviewBounds.minX - radius,
                y: superviewBounds.maxY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        case .centerBottom:
            return CGRect(
                x: superviewBounds.midX - radius,
                y: superviewBounds.maxY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        case .bottomRight:
            return CGRect(
                x: superviewBounds.maxX - radius,
                y: superviewBounds.maxY - radius,
                width: radius * 2.0,
                height: radius * 2.0
            )
        }
    }
    
}

extension SnapPointView {
    fileprivate func initialize() {
        func prepareViews() {
            self.wantsLayer = true
            self.setValue(self.fillColor, forKey: "backgroundColor")
            self.layer?.borderColor = strokeColor.cgColor
            self.layer?.borderWidth = 1.0
        }
        prepareViews()
    }
}
