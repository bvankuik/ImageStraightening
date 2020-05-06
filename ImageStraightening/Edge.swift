//
//  Edge.swift
//  ImageStraightening
//
//  Created by bartvk on 03/05/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct Edge: Shape {
    @Binding var upperLeft: CGSize
    @Binding var lowerLeft: CGSize
    @Binding var lowerRight: CGSize
    @Binding var upperRight: CGSize
    let inset: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: self.upperLeft.width + self.inset, y: self.upperLeft.height + self.inset))
        path.addLine(to: CGPoint(x: self.lowerLeft.width + self.inset, y: self.lowerLeft.height + self.inset))
        path.addLine(to: CGPoint(x: self.lowerRight.width + self.inset, y: self.lowerRight.height + self.inset))
        path.addLine(to: CGPoint(x: self.upperRight.width + self.inset, y: self.upperRight.height + self.inset))
        path.addLine(to: CGPoint(x: self.upperLeft.width + self.inset, y: self.upperLeft.height + self.inset))

        return path
    }
}
