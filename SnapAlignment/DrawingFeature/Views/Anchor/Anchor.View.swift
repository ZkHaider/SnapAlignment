//
//  Anchor.View.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public final class AnchorView: NSView {
    
    // MARK: - Layer
    
    private var shapeLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer
    }
    
    public override func makeBackingLayer() -> CALayer {
        let layer = CAShapeLayer()
        layer.delegate = self
        layer.needsDisplayOnBoundsChange = true
        layer.strokeColor = lineColor.cgColor
        layer.lineWidth = lineWidth
        return layer
    }
    
    // MARK: - Attributes
    
    let anchor: Anchor
    let lineWidth: CGFloat
    let lineColor: NSColor
    
    // MARK: - Init
    
    public init(
        anchor: Anchor,
        lineWidth: CGFloat = 1.0,
        lineColor: NSColor = NSColor.red) {
        self.anchor = anchor
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        super.init(frame: .zero)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func layout() {
        super.layout()
    }
    
}

extension AnchorView: CALayerDelegate {
    
}

extension AnchorView {
    fileprivate func initialize() {
        func prepareViews() {
            self.setValue(self.lineColor, forKey: "backgroundColor")
            self.wantsLayer = true
            self.canDrawConcurrently = true 
        }
        prepareViews()
    }
}
