//
//  Drawing.Window.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

extension NSScreen {
    public var center: CGPoint {
        return CGPoint(x: self.frame.midX,
                       y: self.frame.midY)
    }
}

public final class Window: NSWindow {
    
    public struct Defaults {
        public static let contentRect: NSRect = {
            
            let screenCenter = NSScreen.main?.center ?? .zero
            let size = CGSize(width: 800.0,
                              height: 500.0)
            let offset: CGFloat = 200.0
            let origin = CGPoint(x: screenCenter.x - size.width / 2,
                                 y: (screenCenter.y - size.height / 2) + offset)
            
            return NSRect(origin: origin,
                          size: .init(width: 800.0,
                                      height: 500.0))
        }()
        public static let styleMask: NSWindow.StyleMask = [.miniaturizable, .closable, .titled, .resizable /*.fullScreen*/]
        public static let backing: NSWindow.BackingStoreType = .buffered
        public static let `defer`: Bool = true
    }
    
    // MARK: - Init
    
    public required override init(
        contentRect: NSRect = Defaults.contentRect,
        styleMask style: NSWindow.StyleMask = Defaults.styleMask,
        backing backingStoreType: NSWindow.BackingStoreType = Defaults.backing,
        defer flag: Bool = Defaults.defer) {
        super.init(contentRect: contentRect,
                   styleMask: style,
                   backing: backingStoreType,
                   defer: flag)
        initialize()
    }
    
}

extension Window {
    fileprivate func initialize() {
        func prepare() {
            self.level = NSWindow.Level.normal
        }
        prepare()
    }
}

public typealias DrawingWindow = Window
