//
//  TestView.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/29.
//

import SwiftUI

struct TestView: View {
    @State private var bgColor =
            Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    var body: some View {
        VStack {
            ColorPicker("Alignment Guides", selection: $bgColor)
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
