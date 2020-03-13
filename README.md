# SnapAlignment
Sample repository showing snap to alignment for vector based drawings.

#

Table of contents
=================

- [Models](#models)
- [Views](#views)
- [Algorithm](#algorithm)

Models
======

###### Guide.swift

```swift
public struct GuideMetaInfo {
    public let position: CGFloat
    public let viewHash: Int
    public let direction: GuideDirection
    public let anchor: Anchor
    public let guideColor: NSColor
}

public enum GuideDirection {
    case horizontal
    case vertical
}

public enum Guide {
    
    // MARK: - Cases
    
    case canvas(GuideMetaInfo)
    case shape(GuideMetaInfo)
    
}
```

###### Anchor.swift

```swift
public enum Anchor {
    case top
    case centerX
    case centerY
    case left
    case right
    case bottom
    
    public var guideDirection: GuideDirection {
        switch self {
        case .top:
            return .horizontal
        case .centerX:
            return .horizontal
        case .centerY:
            return .vertical
        case .left:
            return .vertical
        case .right:
            return .vertical
        case .bottom:
            return .horizontal
        }
    }
}
```

###### Guide.Result.swift

```swift
public struct GuideResult {
    public let nearestVerticalGuide: Guide?
    public let nearestHorizontalGuide: Guide?
    public let snapRect: CGRect
}
```

Views
=====

###### Anchor.View.swift

```swift
public final class AnchorView: NSView {

    // MARK: - Attributes
    
    let anchor: Anchor
    let lineWidth: CGFloat
    let lineColor: NSColor
}
```

###### Shape.View.swift

```swift
public final class ShapeView: NSControl {

    // MARK: - Layer
    
    private var shapeLayer: ShapeLayer {
        return self.layer as! ShapeLayer
    }
    
    override public func makeBackingLayer() -> CALayer {
        let shapeLayer = ShapeLayer(paths: self.paths, fillColor: self.color.cgColor)
        shapeLayer.delegate = self
        shapeLayer.needsDisplayOnBoundsChange = true 
        return shapeLayer
    }
    
    // MARK: - Attributes
    
    var paths: Set<Path> = Set()
    var color: NSColor
    let debugMode: Bool
```

###### Drawing.View.swift

```swift
final class DrawingView: NSView {
    
    // MARK: - Views
    
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
    
}
```

Algorithm
=========

1. Initialize a guide state:
1a. `GuideState`:

```swift
public final class GuideState {
    
    // MARK: - Attributes
    
    // A single shape can have multiple guides
    public var shapeGuideCache: [ShapeView.ShapeGuideIdentifier: Set<Guide>]
    
    // Our canvas has a 1 guide per 1 view
    public var canvasGuideCache: [DrawingViewController.CanvasGuideIdentifier: Guide]
    
    public var shapeGuides: Set<Guide> {
        return shapeGuideCache.values
            .reduce(
                into: Set<Guide>(),
                { $0.formUnion($1) }
            )
    }
    
    public var canvasGuides: Set<Guide> {
        return Set(canvasGuideCache.values)
    }
    
    public var allGuides: Set<Guide> {
        return canvasGuides.union(shapeGuides)
    }
    
    /// Threshold until a view snaps -- 6 px
    public let guideThreshold: CGFloat
    
    // MARK: - Init
    
    public init(
        shapeGuideCache: [ShapeView.ShapeGuideIdentifier: Set<Guide>] = [:],
        canvasGuideCache: [DrawingViewController.CanvasGuideIdentifier: Guide] = [:],
        guideThreshold: CGFloat = 6.0)
    {
        self.shapeGuideCache = shapeGuideCache
        self.canvasGuideCache = canvasGuideCache
        self.guideThreshold = guideThreshold
    }
    
}

```

