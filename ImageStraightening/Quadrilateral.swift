//
//  Quadrilateral.swift
//  ImageStraightening
//
//  Created by bartvk on 04/05/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import CoreImage

struct Quadrilateral {
    let correction: CGFloat
    var topLeftOffset = CGSize()
    var bottomLeftOffset = CGSize()
    var bottomRightOffset = CGSize()
    var topRightOffset = CGSize()

    func scaledPoints(using scaleX: CGFloat, y: CGFloat) -> [CGPoint] {
        let transform = CGAffineTransform(scaleX: scaleX, y: y)
        let topLeft = CGPoint(x: self.topLeftOffset.width + self.correction / 2.0,
                              y: self.topLeftOffset.height + self.correction / 2.0)
            .applying(transform)
        let bottomLeft = CGPoint(x: self.bottomLeftOffset.width + self.correction / 2.0,
                                 y: self.bottomLeftOffset.height + self.correction / 2.0)
            .applying(transform)
        let bottomRight = CGPoint(x: self.bottomRightOffset.width + self.correction / 2.0,
                                  y: self.bottomRightOffset.height + self.correction / 2.0)
            .applying(transform)
        let topRight = CGPoint(x: self.topRightOffset.width + self.correction / 2.0,
                               y: self.topRightOffset.height + self.correction / 2.0)
            .applying(transform)

        return [topLeft.ceiled(), bottomLeft.ceiled(), bottomRight.ceiled(), topRight.ceiled()]
    }
}

extension CGPoint {
    func ceiled() -> CGPoint {
        CGPoint(x: ceil(self.x), y: ceil(self.y))
    }
}
