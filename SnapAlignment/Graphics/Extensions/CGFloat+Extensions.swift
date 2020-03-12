//
//  CGFloat+Extensions.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

extension CGFloat {
    
    var radians: CGFloat {
        return self * .pi / 180
    }
    
    var degrees: CGFloat {
        return self * (180 / .pi)
    }
    
}
