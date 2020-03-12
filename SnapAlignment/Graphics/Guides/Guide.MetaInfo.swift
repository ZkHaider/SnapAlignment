//
//  Guide.MetaInfo.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

public struct GuideMetaInfo {
    public let position: CGFloat
    public let viewHash: Int
    public let direction: GuideDirection
    public let anchor: Anchor
    public let guideColor: NSColor
}

extension GuideMetaInfo: Equatable {}

extension GuideMetaInfo: Hashable {}
