//
//  Sizer.swift
//  ImageStraightening
//
//  Created by bartvk on 03/05/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import CoreGraphics
import SwiftUI

struct Sizer: View {
    @Binding var quadrilateral: Quadrilateral
    @State private var currentFrameSize = CGSize()
    private var handleDiameter: CGFloat {
        self.quadrilateral.correction
    }
    private var handleRadius: CGFloat {
        self.quadrilateral.correction / 2.0
    }
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .topLeading) {
                DraggableHandle(title: "topleft", radius: self.handleDiameter, offset: self.$quadrilateral.topLeftOffset)
                    .frame(width: reader.size.width, height: reader.size.height, alignment: .topLeading)
                DraggableHandle(title: "bottomLeft", radius: self.handleDiameter, offset: self.$quadrilateral.bottomLeftOffset)
                    .frame(width: reader.size.width, height: reader.size.height, alignment: .topLeading)
                DraggableHandle(title: "bottomRight", radius: self.handleDiameter, offset: self.$quadrilateral.bottomRightOffset)
                    .frame(width: reader.size.width, height: reader.size.height, alignment: .topLeading)
                DraggableHandle(title: "topRight", radius: self.handleDiameter, offset: self.$quadrilateral.topRightOffset)
                    .frame(width: reader.size.width, height: reader.size.height, alignment: .topLeading)
                Edge(upperLeft: self.$quadrilateral.topLeftOffset,
                     lowerLeft: self.$quadrilateral.bottomLeftOffset,
                     lowerRight: self.$quadrilateral.bottomRightOffset,
                     upperRight: self.$quadrilateral.topRightOffset,
                     inset: self.handleDiameter / 2.0)
                    .stroke(Color.red.opacity(0.8), lineWidth: 5)
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .onAppear {
                guard self.currentFrameSize == CGSize() else {
                    // We're injecting values (perhaps because we're testing) so don't initialize values
                    return
                }
                self.currentFrameSize = reader.size
                self.quadrilateral.topLeftOffset = CGSize(width: -self.handleRadius, height: -self.handleRadius)
                self.quadrilateral.bottomLeftOffset = CGSize(width: -self.handleRadius,
                                                             height: reader.size.height - self.handleRadius)
                self.quadrilateral.bottomRightOffset = CGSize(width: reader.size.width - self.handleRadius,
                                                              height: reader.size.height - self.handleRadius)
                self.quadrilateral.topRightOffset = CGSize(width: reader.size.width - self.handleRadius,
                                                           height: -self.handleRadius)
            }
        }
    }
}
