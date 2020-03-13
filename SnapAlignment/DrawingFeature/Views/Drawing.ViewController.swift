//
//  ViewController.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Cocoa

public class DrawingViewController: NSViewController {
    
    // MARK: - Defintions
    
    public typealias CanvasGuideIdentifier = Int
    
    // MARK: - ViewModel
    
    var drawingViewModel: DrawingViewModel
    
    // MARK: - View
    
    var _view: DrawingView {
        return self.view as! DrawingView
    }
    
    // MARK: - Init
    
    public init() {
        self.drawingViewModel = DrawingViewModel(
            guideState: GuideState(
                shapeGuideCache: [:],
                canvasGuideCache: [:]
            )
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override public func loadView() {
        let drawingView = DrawingView(frame: .zero)
        self.view = drawingView
        drawingView.draggingGuideDelegate = self
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set up canvas anchor guides
        for anchorView in self._view.anchorViews {
            self.drawingViewModel.guideState.addCanvasGuide(
                .canvas(
                    GuideMetaInfo(
                        position: 0.0,
                        viewHash: anchorView.objectHash,
                        direction: anchorView.anchor.guideDirection,
                        anchor: anchorView.anchor,
                        guideColor: anchorView.lineColor
                    )
                ),
                for: anchorView.objectHash
            )
        }
    }
    
    public override func viewWillLayout() {
        super.viewWillLayout()
    }
    
    override public func viewDidLayout() {
        super.viewDidLayout()
        
        let bounds = self._view.bounds
        
        // 1. Find canvas guide view
        // 2. Update rect
        // 3. Set frame
        for (canvasGuideViewIdentifier, guide) in self.drawingViewModel.guideState.canvasGuideCache {
            guard
                let canvasAnchorView = self._view.anchorViews
                    .first(where: { $0.objectHash == canvasGuideViewIdentifier })
                else { continue }

            let guideRect = guide.rect(
                for: bounds,
                inside: bounds
            )
            canvasAnchorView.frame = guideRect
            self.drawingViewModel.update(guide)
        }
    }
    
}

// MARK: - Toolbar Contract

extension DrawingViewController: DrawingToolbarContract {
    
    public func addPolygonShape(_ polygon: Polygon) {
        let shapeView = ShapeView(paths: polygon.paths)
        drawingViewModel.addShapeGuides(for: shapeView, in: _view)
        _view.addShapeView(shapeView)
    }
    
    public func addCircleShape(_ circle: Circle) {
        let shapeView = ShapeView(paths: circle.paths)
        drawingViewModel.addShapeGuides(for: shapeView, in: _view)
        _view.addShapeView(shapeView)
    }
    
    public func addSquareShape(_ square: Square) {
        let shapeView = ShapeView(paths: square.paths)
        drawingViewModel.addShapeGuides(for: shapeView, in: _view)
        _view.addShapeView(shapeView)
    }
    
}

// MARK: - Dragging Guide Contract

extension DrawingViewController: DraggingGuideContract {
    
    public func startDrag(
        _ view: ShapeView,
        in superview: NSView,
        event: NSEvent)
    {
        self.drawingViewModel.startingDrag(
            for: view,
            in: superview,
            event: event
        )
    }
    
    public func didDrag(
        _ view: ShapeView,
        in superview: NSView,
        event: NSEvent)
    {
        self.drawingViewModel.dragging(
            for: view,
            in: superview,
            event: event
        )
    }
    
    public func endedDrag(
        _ view: ShapeView,
        in superview: NSView,
        event: NSEvent)
    {
        self.drawingViewModel.endingDrag(
            for: view,
            in: superview,
            event: event
        )
    }
    
}
