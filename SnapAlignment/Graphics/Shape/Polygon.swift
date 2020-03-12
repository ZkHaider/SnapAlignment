//
//  Polygon.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public struct Polygon {
    public var corners: [CGPoint] = []
}

extension Polygon: Drawable {
    
    public var paths: Set<Path> {
        let paths: [Path] = zip(corners, corners.dropFirst() + corners.prefix(1))
            .map(Path.Line.init)
            .map(Path.line)
        return Set(paths)
    }
    
}
