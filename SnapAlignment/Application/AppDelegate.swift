//
//  AppDelegate.swift
//  SnapAlignment
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import AppKit

@NSApplicationMain
class AppDelegate: ApplicationDelegate {
    
    lazy var windowController: DrawingWindowController = {
        let viewController = DrawingViewController()
        let window = DrawingWindow()
        window.contentViewController = viewController
        let windowController = DrawingWindowController(window: window)
        windowController.drawingContract = viewController 
        windowController.contentViewController = viewController
        return windowController
    }()

    override func applicationDidFinishLaunching(_ notification: Notification) {
        
        self.windowController.window?.title = "Drawing Application"
        self.windowController.window?.styleMask = DrawingWindow.Defaults.styleMask
        self.windowController.showWindow(self)
        self.windowController.window?.setFrame(
            DrawingWindow.Defaults.contentRect,
            display: true,
            animate: true
        )
    }
    
    public func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return .terminateNow
    }
    
}

