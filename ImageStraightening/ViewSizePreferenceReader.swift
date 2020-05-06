//
//  ViewSizePreferenceReader.swift
//  ImageStraightening
//
//  Created by bartvk on 04/05/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct ViewSizePreferenceKey: PreferenceKey {
    typealias Value = [CGSize]
    
    static var defaultValue: [CGSize] = []
    
    static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewSizePreferenceReader: View {
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
             Rectangle().fill(Color.clear) //.border(Color.purple, width: 2)
                .preference(key: ViewSizePreferenceKey.self, value: [geometry.size])
        }
    }
}
