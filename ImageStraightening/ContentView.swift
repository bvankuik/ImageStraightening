//
//  ContentView.swift
//  ImageStraightening
//
//  Created by bartvk on 30/04/2020.
//  Copyright © 2020 DutchVirtual. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ImageStraightener()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone SE")
    }
}
