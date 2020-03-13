//
//  Guide.Result.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/12/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import Foundation

public struct GuideResult {
    
    public let nearestVerticalGuide: Guide?
    public let nearestHorizontalGuide: Guide?
    public let snapRect: CGRect
    
    public init(
        nearestVerticalGuide: Guide?,
        nearestHorizontalGuide: Guide?,
        snapRect: CGRect)
    {
        self.nearestVerticalGuide = nearestVerticalGuide
        self.nearestHorizontalGuide = nearestHorizontalGuide
        self.snapRect = snapRect
    }
}
