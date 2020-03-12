//
//  Drawing.Toolbar.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

internal extension NSToolbarItem.Identifier {
    static let polygonItem = NSToolbarItem.Identifier("polygon")
    static let circleItem = NSToolbarItem.Identifier("circle")
    static let squareItem = NSToolbarItem.Identifier("square")
}

public final class DrawingToolbar: NSToolbar {
    
    // MARK: - Items
    
    let toolBarItemIdentifiers: [NSToolbarItem.Identifier] = [
        .polygonItem,
        .circleItem,
        .squareItem,
        .flexibleSpace
    ]
    
    let toolBarItems: [NSToolbarItem] = {
        
        let polygonItem: NSToolbarItem = NSToolbarItem(itemIdentifier: .polygonItem)
        polygonItem.toolTip = "A polygon shape"
        polygonItem.minSize = CGSize(width: 80.0, height: 40.0)
        polygonItem.maxSize = CGSize(width: 80.0, height: 40.0)
        
        let circleItem: NSToolbarItem = NSToolbarItem(itemIdentifier: .circleItem)
        circleItem.toolTip = "A circle shape"
        circleItem.minSize = CGSize(width: 80.0, height: 40.0)
        circleItem.maxSize = CGSize(width: 80.0, height: 40.0)
        
        let squareItem: NSToolbarItem = NSToolbarItem(itemIdentifier: .squareItem)
        squareItem.toolTip = "A square shape"
        squareItem.minSize = CGSize(width: 80.0, height: 40.0)
        squareItem.maxSize = CGSize(width: 80.0, height: 40.0)
        
        let items: [NSToolbarItem] = [
            polygonItem,
            circleItem,
            squareItem
        ]
        
        return items
    }()
    
    // MARK: - Init
    
    public override init(identifier: NSToolbar.Identifier) {
        super.init(identifier: identifier)
        initialize()
    }
    
}

extension DrawingToolbar {
    fileprivate func initialize() {
        func prepare() {
            
        }
        prepare()
    }
}
