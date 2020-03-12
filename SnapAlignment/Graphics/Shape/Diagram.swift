//
//  Diagram.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public struct Diagram {
    var elements: [Drawable] = []
}

extension Diagram: Drawable {
    
    public var paths: Set<Path> {
        return elements
            .map { $0.paths }
            .reduce(into: Set<Path>(), { $0.formUnion($1) })
    }
    
}
