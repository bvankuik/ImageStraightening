//
//  ImageStraightener.swift
//  ImageStraightening
//
//  Created by bartvk on 27/05/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct ImageStraightener: View {
    enum Mode {
        case initialized, corrected
    }
    private static let handleDiameter: CGFloat = 88
    @State private var quadrilateral = Quadrilateral(correction: Self.handleDiameter)
    @State private var correctedImage: CIImage?
    @State private var image = Self.startImage
    @State private var displayedSize = CGSize()
    private static let startImage = UIImage(named: "example3")!
    @State private var mode = Mode.initialized

    var body: some View {
        VStack {
            HStack {
                Image(uiImage: self.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(Sizer(quadrilateral: self.$quadrilateral).clipped().opacity(self.mode == .initialized ? 1 : 0))
                    .overlay(ViewSizePreferenceReader())
                    .onPreferenceChange(ViewSizePreferenceKey.self) { preferences in
                        self.displayedSize = preferences.first ?? CGSize()
                    }
            }.padding(20)
            Spacer()
            HStack {
                Button("Correct") {
                    guard let cgImage = self.image.cgImage else {
                        return
                    }
                    let scaleX = CGFloat(cgImage.width) / self.displayedSize.width
                    let scaleY = CGFloat(cgImage.height) / self.displayedSize.height
                    let scaledPoints = self.quadrilateral.scaledPoints(using: scaleX, y: scaleY)
                    print(scaledPoints)
                    self.image = self.image.correctPerspective(points: scaledPoints)
                    self.mode = .corrected
                }.disabled(self.mode == .corrected)
                Button("Reset") {
                    self.image = Self.startImage
                    self.mode = .initialized
                }.disabled(self.mode == .initialized)
            }
        }
    }
}

struct ImageStraightener_Previews: PreviewProvider {
    static var previews: some View {
        ImageStraightener()
            .previewDevice("iPhone SE")
    }
}
