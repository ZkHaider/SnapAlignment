//
//  Positioning.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public struct Snaping<U: ShapeView, V: ShapeView> {
    let snap: (U, V) -> Void
}
