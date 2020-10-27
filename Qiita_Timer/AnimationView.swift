//
//  AnimationView.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/25.
//

import SwiftUI

struct AnimationView: View {
    @EnvironmentObject var timeManager: TimeManager
    @State var costomHueA: Double = 0.5
    @State var costomHueB: Double = 0.3
    @State var clockwise = true
    @State var count: Double = 0
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 20, height: 20)
                .offset(y: -self.screenWidth * 0.38)
                .foregroundColor(Color(hue: self.costomHueA, saturation: 1.0, brightness: 1.0, opacity: 0.5))
                .rotationEffect(.degrees(clockwise ? 0 : 360))
                .animation(.easeInOut(duration: 5))
            
            Circle()
                .frame(width: 20, height: 20)
                .offset(y: -self.screenWidth * 0.38)
                .foregroundColor(Color(hue: self.costomHueB, saturation: 1.0, brightness: 1.0, opacity: 0.5))
                .rotationEffect(.degrees(clockwise ? 360 : 0))
                .animation(.easeInOut(duration: 5))
        }
        .onReceive(timeManager.timer) { _ in
            if self.count <= 0 {
                self.clockwise.toggle()
            }
            if self.count < 5.00 {
                self.count += 0.05
            } else {
                self.count = 0
            }
            
            self.costomHueA += 0.005
            if self.costomHueA >= 1.0 {
                self.costomHueA = 0.0
            }
            self.costomHueB += 0.005
            if self.costomHueB >= 1.0 {
                self.costomHueB = 0.0
            }
        }
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
            .environmentObject(TimeManager())
    }
}
