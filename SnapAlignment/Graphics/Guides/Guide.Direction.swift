//
//  Guide.Direction.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public enum GuideDirection {
    case horizontal
    case vertical
}

extension GuideDirection: Equatable, Hashable {
    
    public static func ==(lhs: GuideDirection,
                          rhs: GuideDirection) -> Bool {
        switch lhs {
        case .horizontal:
            switch rhs {
            case .horizontal: return true
            default: return false
            }
        case .vertical:
            switch rhs {
            case .vertical: return true
            default: return false
            }
        }
    }
    
}
