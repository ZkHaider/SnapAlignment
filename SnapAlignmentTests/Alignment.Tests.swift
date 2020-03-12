//
//  Alignment.Tests.swift
//  SnapAlignmentTests
//
//  Created by Haider Khan on 3/11/20.
//  Copyright © 2020 zkhaider. All rights reserved.
//

import XCTest
@testable import SnapAlignment

final class AlignmentTests: XCTestCase {
    
    lazy var contentView: NSView = {
        let view = NSView(
            frame: NSRect(
                x: 0.0,
                y: 0.0,
                width: 800.0,
                height: 1200.0
            )
        )
        return view
    }()
    
    lazy var firstShapeView: ShapeView = {
        let view = ShapeView(
            paths: Square(
                origin: .zero,
                radius: 40.0
            ).paths
        )
        contentView.addSubview(view)
        return view
    }()
    
    lazy var secondShapeView: ShapeView = {
        let view = ShapeView(
            paths: Square(
                origin: CGPoint(
                    x: 60.0,
                    y: 30.0
                ),
                radius: 60.0
            ).paths
        )
        contentView.addSubview(view)
        return view
    }()

    // MARK: - Tests
    
    func testTopLeftToTopRight() {
        layoutViews()
        
        guard
            let snapPointPair = Aligning<TopLeft, TopRight>
                .aligner
                .align(firstShapeView, secondShapeView)
            else {
                assertionFailure("Could not generrate snap-point pair. Check implementation.")
                return
        }
        
        // 180.0 px is the distance from the center point of the top left
        // snap point of the first view --> to the top right snap point
        // of the second view.
        assert(snapPointPair.distance == 180.0, "Distance is not correct.")
    }
    
    func testTopRightToTopLeft() {
        layoutViews()
        
        guard
            let snapPointPair = Aligning<TopRight, TopLeft>
                .aligner
                .align(firstShapeView, secondShapeView)
            else {
                assertionFailure("Could not generrate snap-point pair. Check implementation.")
                return
        }
        
        // 20.0 px from right side to left side
        assert(snapPointPair.distance == 20.0, "Distance is not correct.")
    }
    
    func testTopLeftToTopLeft() {
        layoutViews()
        
        guard
            let snapPointPair = Aligning<TopLeft, TopLeft>
                .aligner
                .align(firstShapeView, secondShapeView)
            else {
                assertionFailure("Could not generrate snap-point pair. Check implementation.")
                return
        }
        
        // 60.0 px from left side to other left side
        assert(snapPointPair.distance == 60.0, "Distance is not correct.")
    }
    
    func testTopRightToTopRight() {
        layoutViews()
        
        guard
            let snapPointPair = Aligning<TopRight, TopRight>
                .aligner
                .align(firstShapeView, secondShapeView)
            else {
                assertionFailure("Could not generrate snap-point pair. Check implementation.")
                return
        }
        
        // 100.0 px from right side to other right side
        assert(snapPointPair.distance == 100.0, "Distance is not correct.")
    }
    
    // MARK: - Accessory
    
    fileprivate func layoutViews() {
        contentView.layout()
        firstShapeView.layout()
        secondShapeView.layout()
    }
    
}
