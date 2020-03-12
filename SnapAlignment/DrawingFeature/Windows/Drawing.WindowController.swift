//
//  Drawing.WindowController.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public final class WindowController: NSWindowController {
    
    // MARK: - Views
    
    let drawingToolbar: DrawingToolbar = {
        let view = DrawingToolbar(identifier: "drawingToolBar")
        return view
    }()
    
    // MARK: - Delegates
    
    weak var drawingContract: DrawingToolbarContract? = nil 
    
    // MARK: - Init
    
    public required init(window: DrawingWindow) {
        super.init(window: window)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    // MARK: - Action Target
    
    @objc
    fileprivate func handlePolygonClick(_ button: ToolbarButton) {
        
        let polygon = Polygon(
            corners: [
                .init(x: 0.0, y: 0.0),
                .init(x: 100.0, y: 0.0),
                .init(x: 30.0, y: 60.0)
            ]
        )
        drawingContract?.addPolygonShape(polygon)
    }
    
    @objc
    fileprivate func handleCircleClick(_ button: ToolbarButton) {
        
        let circle = Circle(
            center: .init(x: 40.0, y: 40.0),
            radius: 40.0
        )
        drawingContract?.addCircleShape(circle)
    }
    
    @objc
    fileprivate func handleSquareClick(_ button: ToolbarButton) {
           
        let square = Square(origin: .zero, radius: 60.0)
        drawingContract?.addSquareShape(square)
    }
    
}

extension WindowController {
    fileprivate func initialize() {
        func prepareViews() {
            self.window?.delegate = self
            self.drawingToolbar.delegate = self
            self.window?.toolbar = self.drawingToolbar
        }
        prepareViews()
    }
}

extension WindowController: NSWindowDelegate {
    
}

extension WindowController: NSToolbarDelegate {
    
    public func toolbar(_ toolbar: NSToolbar,
                        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                        willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case .flexibleSpace:
            return NSToolbarItem(itemIdentifier: .flexibleSpace)
        case .polygonItem:
            let toolbarItem = self.drawingToolbar.toolBarItems.first(where: { $0.itemIdentifier == .polygonItem })
            let polygonButton = ToolbarButton(
                frame: .zero
            )
            polygonButton.setButtonType(.momentaryPushIn)
            polygonButton.title = "Polygon"
            polygonButton.bezelStyle = .rounded
            polygonButton.target = self
            polygonButton.action = #selector(handlePolygonClick(_:))
            toolbarItem?.view = polygonButton
            return toolbarItem
        case .circleItem:
            let toolbarItem = self.drawingToolbar.toolBarItems.first(where: { $0.itemIdentifier == .circleItem })
            let circleButton = ToolbarButton(
                frame: .zero
            )
            circleButton.setButtonType(.momentaryPushIn)
            circleButton.title = "Circle"
            circleButton.bezelStyle = .rounded
            circleButton.target = self
            circleButton.action = #selector(handleCircleClick(_:))
            toolbarItem?.view = circleButton
            return toolbarItem
        case .squareItem:
            let toolbarItem = self.drawingToolbar.toolBarItems.first(where: { $0.itemIdentifier == .squareItem })
            let squareButton = ToolbarButton(
                frame: .zero
            )
            squareButton.setButtonType(.momentaryPushIn)
            squareButton.title = "Square"
            squareButton.bezelStyle = .rounded
            squareButton.target = self
            squareButton.action = #selector(handleSquareClick(_:))
            toolbarItem?.view = squareButton
            return toolbarItem
        default: return NSToolbarItem()
        }
    }
    
    public func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.drawingToolbar.toolBarItemIdentifiers
    }
    
    public func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.drawingToolbar.toolBarItemIdentifiers
    }
    
}

public typealias DrawingWindowController = WindowController
