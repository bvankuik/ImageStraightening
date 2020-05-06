//
//  ImageStraighteningTests.swift
//  ImageStraighteningTests
//
//  Created by bartvk on 03/05/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import XCTest
import SwiftUI

class ImageStraighteningTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSizer() throws {
        let screenSize = CGSize(width: 320, height: 500)
        let quadrilateral = Quadrilateral(correction: 44, topLeftOffset: CGSize(width: 20, height: 20),
                                          bottomLeftOffset: CGSize(width: 20, height: 480),
                                          bottomRightOffset: CGSize(width: 300, height: 480),
                                          topRightOffset: CGSize(width: 300, height: 20))

        // example1 size: 3024 × 4032
        guard let image = UIImage(named: "example1") else {
            XCTAssert(true, "image wasn't found")
            return
        }
        
        let scales = image.scaleWidthHeight(for: screenSize)
        guard let scaleX = scales.first, let scaleY = scales.last else {
            return
        }
        
//        let scaledPoints = quadrilateral.scaledPoints(using: scaleX, y: scaleY)
        let scaledPoints = [
            CGPoint(x: 1000, y: 1000),
            CGPoint(x: 1000, y: 4032),
            CGPoint(x: 3024, y: 4032),
            CGPoint(x: 3024, y: 1000)
        ]

        let correctedImage = image.correctPerspective(points: scaledPoints)
        guard let correctedCGImage = correctedImage.cgImage else {
            XCTAssert(false, "correctedCGImage should be present")
            return
        }
        XCTAssert(correctedCGImage.width > 1000 && correctedCGImage.height > 1000)
        
//
//        let offsets = sizer.points(for: image.size)
//        XCTAssert(offsets.count == 4)
//        guard offsets.count == 4 else {
//            return
//        }
//
        // Image size is 3024x4032

        // See if bottom right is roughly in the correct range
//        XCTAssert(quadr.x > 2700 && offsets[2].x < 2900 &&
//            offsets[2].y > 3700 && offsets[2].y < 3900)
    }
}
