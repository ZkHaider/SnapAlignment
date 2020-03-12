//
//  Drawing.Toolbar.Contract.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public protocol DrawingToolbarContract: class {
    func addPolygonShape(_ polygon: Polygon)
    func addCircleShape(_ circle: Circle)
    func addSquareShape(_ square: Square)
}
