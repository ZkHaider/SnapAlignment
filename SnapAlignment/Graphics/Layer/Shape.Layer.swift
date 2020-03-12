//
//  Shape.Layer.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public protocol AnyShapeLayer: class {
    var paths: Set<Path> { get }
    var shapeFillColor: CGColor { get }
    var shapeStrokeColor: CGColor { get }
}

public final class ShapeLayer: CAShapeLayer, AnyShapeLayer {
    
    // MARK: - Attributes
    
    public var paths: Set<Path>
    public var shapeFillColor: CGColor
    public var shapeStrokeColor: CGColor
    
    public override var masksToBounds: Bool {
        set { }
        get { return false }
    }
    
    // MARK: - Init
    
    public init(
        paths: Set<Path>,
        fillColor: CGColor = NSColor.red.cgColor,
        strokeColor: CGColor = NSColor.clear.cgColor)
    {
        self.paths = paths
        self.shapeFillColor = fillColor
        self.shapeStrokeColor = strokeColor
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Drawing
    
    override public func draw(in ctx: CGContext) {
        ctx.draw(
            self.paths,
            withFill: self.shapeFillColor,
            withStroke: self.shapeStrokeColor
        )
    }
    
}
