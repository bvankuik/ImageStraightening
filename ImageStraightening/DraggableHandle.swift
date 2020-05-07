//
//  DraggableHandle.swift
//  ImageStraightening
//
//  Created by bartvk on 03/05/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct Handle: View {
    let radius: CGFloat
    var body: some View {
        Circle().fill(Color.blue.opacity(0.6))
            .frame(width: self.radius, height: self.radius)
    }
}

struct DraggableHandle: View {
    let title: String
    let radius: CGFloat
    @Binding var offset: CGSize
    @State private var previousOffset = CGSize()
    var body: some View {
        Handle(radius: self.radius)
//            .overlay(Text(self.title)) // useful for debugging
            .offset(self.offset)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { event in
                        self.offset = CGSize(width: event.location.x - (event.startLocation.x - self.previousOffset.width),
                                                    height: event.location.y - (event.startLocation.y - self.previousOffset.height))
                    }
                    .onEnded { _ in
                        print("\(self.title) self.offset = \(self.offset)")
                        self.previousOffset = self.offset
                    }
            )
            .onAppear { self.previousOffset = self.offset }
    }
}

struct DraggableHandle_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle().fill(Color.yellow).frame(width: 200, height: 100)
            .overlay(DraggableHandle(title: "Test", radius: 40, offset: .constant(CGSize())))
    }
}
