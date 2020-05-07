//
//  UIImage+Utilities.swift
//  ImageStraightening
//
//  Created by bartvk on 05/05/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import UIKit
import CoreImage

extension UIImage {
    public func correctPerspective(points: [CGPoint]) -> UIImage {
        guard let cgImage = self.cgImage else {
            return UIImage()
        }
        let ciImage = CIImage(cgImage: cgImage)

        let inputParameters = [
            "inputTopLeft": CIVector(cgPoint: CGPoint(x: points[0].x, y: CGFloat(cgImage.height) - points[0].y)),
            "inputTopRight": CIVector(cgPoint: CGPoint(x: points[3].x, y: CGFloat(cgImage.height) - points[3].y)),
            "inputBottomLeft": CIVector(cgPoint: CGPoint(x: points[1].x, y: CGFloat(cgImage.height) - points[1].y)),
            "inputBottomRight": CIVector(cgPoint: CGPoint(x: points[2].x, y: CGFloat(cgImage.height) - points[2].y))
        ]
        print(inputParameters)
        
        let correctedCIImage = ciImage.applyingFilter("CIPerspectiveCorrection", parameters: inputParameters)
        let context = CIContext()
        guard let correctedCGImage = context.createCGImage(correctedCIImage, from: correctedCIImage.extent) else {
            fatalError("Couldn't create cgImage")
        }
        let correctedUIImage = UIImage(cgImage: correctedCGImage)
        return correctedUIImage
    }
}
