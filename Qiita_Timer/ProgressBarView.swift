//
//  ProgressBarView.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/23.
//

import SwiftUI

struct ProgressBarView: View {
    @EnvironmentObject var timeManager: TimeManager

    @State var costomHueA = 0.4
    @State var costomHueB = 0.1
    @State var costomHueRunningA = 0.4
    @State var costomHueRunningB = 0.1

    var body: some View {
        ZStack {
            if self.timeManager.timerStatus == .stopped {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    Circle()
                        .stroke(self.makeGradientColor(hueA: costomHueA , hueB: costomHueB), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.8, alignment: .center)
                        .padding(15)
                } else {
                    Circle()
                        .stroke(self.makeGradientColor(hueA: costomHueA , hueB: costomHueB), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .scaledToFit()
                        .padding(15)
                }
                
            } else if self.timeManager.timerStatus == .running {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    Circle()
                        .stroke(Color(.darkGray), style: StrokeStyle(lineWidth: 20))
                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.8, alignment: .center)
                        .padding(15)
                        .opacity(0.3)
                    Circle()
                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.8, alignment: .center)
                        .padding(25)
                        .foregroundColor(Color.white)
                    Image("bom2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 250, alignment: .center)
                        .cornerRadius(100)
                } else {
                    Circle()
                        .stroke(Color(.darkGray), style: StrokeStyle(lineWidth: 20))
                        .scaledToFit()
                        .padding(15)
                        .opacity(0.3)
                    Circle()
                        .scaledToFit()
                        .padding(25)
                        .foregroundColor(Color.white)
                    Image("bom2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 250, alignment: .center)
                        .cornerRadius(100)
                }
                
            } else {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    Circle()
                        .stroke(Color(.darkGray), style: StrokeStyle(lineWidth: 20))
                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.8, alignment: .center)
                        .padding(15)
                        .opacity(0.3)
                    Circle()
                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.8, alignment: .center)
                        .padding(25)
                        .foregroundColor(Color.white)
                        .opacity(0.97)
                    Image("bom2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 250, alignment: .center)
                        .cornerRadius(100)
                        .opacity(0.3)
                } else {
                    Circle()
                        .stroke(Color(.darkGray), style: StrokeStyle(lineWidth: 20))
                        .scaledToFit()
                        .padding(15)
                        .opacity(0.3)
                    Circle()
                        .scaledToFit()
                        .padding(25)
                        .foregroundColor(Color.white)
                        .opacity(0.97)
                    Image("bom2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 250, alignment: .center)
                        .cornerRadius(100)
                        .opacity(0.3)
                }
                
            }
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                //プログレスバー用の円
                Circle()
                    .trim(from: 0, to: CGFloat(self.timeManager.duration / self.timeManager.maxValue))
                    .stroke(self.makeGradientColor(hueA: costomHueA , hueB: costomHueB), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.8, alignment: .center)
                    .rotationEffect(Angle(degrees: -90))
                    .padding(15)
            } else {
                Circle()
                    .trim(from: 0, to: CGFloat(self.timeManager.duration / self.timeManager.maxValue))
                    .stroke(self.makeGradientColor(hueA: costomHueA , hueB: costomHueB), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: -90))
                    .padding(15)
            }
            
        }
        //毎0.05秒ごとに発動
        .onReceive(timeManager.timer) { _ in

            if self.timeManager.timerStatus == .stopped {
                self.costomHueA += 0.0025
                self.costomHueB += 0.005
                self.costomHueRunningA = 0.0
                self.costomHueRunningB = 0.0
            } else {
                if self.timeManager.duration < 5 {
                    self.costomHueRunningA += 0.05
                    self.costomHueRunningB += 0.05
                } else {
                    self.costomHueRunningA += CGFloat( 0.05 / self.timeManager.maxValue)
                    self.costomHueRunningB += CGFloat( 0.05 / self.timeManager.maxValue)
                }
                self.costomHueA = costomHueRunningA
                self.costomHueB = costomHueRunningB
            }
            //print(costomHueA, costomHueB)
            if self.costomHueA >= 1.0 {
                self.costomHueA = 0.0
                self.costomHueRunningA = 0.0
            }
            if self.costomHueB >= 1.0 {
                self.costomHueB = 0.0
                self.costomHueRunningB = 0.0
            }
        }
    }

    
    func makeGradientColor(hueA: Double, hueB: Double) -> AngularGradient {
        let colorA = Color(hue: hueA, saturation: 0.75, brightness: 0.9)
        let colorB = Color(hue: hueB, saturation: 0.75, brightness: 0.9)
        let gradient = AngularGradient(gradient: .init(colors: [colorA, colorB, colorA]), center: .center, startAngle: .zero, endAngle: .init(degrees: 360))
        return gradient
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}
