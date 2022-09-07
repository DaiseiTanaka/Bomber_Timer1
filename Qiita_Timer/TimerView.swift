//
//  TimerView.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/16.
//

import SwiftUI

struct TimerView: View {

    @EnvironmentObject var timeManager: TimeManager
    @State var costomHueA = 0.4
    @State var costomHueB = 0.1
    @State var costomHueRunningA = 0.4
    @State var costomHueRunningB = 0.1

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            //時間表示形式が時間、分、秒によって、タイマーの文字サイズを条件分岐させる
            //表示形式が"時間"の場合
            if self.timeManager.displayedTimeFormat == .hr {
                Text(self.timeManager.displayTimer())
                //文字サイズをスクリーンサイズ x 0.15に指定
                    .font(.system(size: self.screenWidth * 0.15, weight: .thin, design: .monospaced))
                //念の為、行数を1行に指定
                    .lineLimit(1)
                //デフォルトの余白を追加
                    .padding()
                
                //表示形式が"分"の場合
            } else if self.timeManager.displayedTimeFormat == .min && self.timeManager.duration > 59{
                let m =  self.screenWidth * 0.23 + 25 * (Double(self.timeManager.duration).truncatingRemainder(dividingBy: 1))
                if self.timeManager.duration > 10 {
                    Text(self.timeManager.displayTimer())
                        .font(.custom("DBLCDTempBlack", size: self.screenWidth * 0.23))
                        .lineLimit(1)
                        .padding()
                        .foregroundColor(Color(UIColor.lightGray))
                } else {
                    Text(self.timeManager.displayTimer())
                        .font(.custom("DBLCDTempBlack", size: m))
                        .lineLimit(1)
                        .padding()
                        .foregroundColor(Color.red)
                }
                
                //表示形式が"秒"の場合
            } else {
                let s =  self.screenWidth * 0.4 + 25 * (Double(self.timeManager.duration).truncatingRemainder(dividingBy: 1))

                if self.timeManager.duration > 10 {
                    Text(self.timeManager.displayTimer())
//                        .font(.system(size: self.screenWidth * 0.5, weight: .thin, design: .monospaced))
                        .font(.custom("DBLCDTempBlack", size: self.screenWidth * 0.4))
                        .fontWeight(.thin)
                        .lineLimit(1)
                        .padding()
                        .foregroundColor(Color(UIColor.lightGray))
                } else {
                    Text(self.timeManager.displayTimer())
//                        .font(.system(size: self.screenWidth * 0.5 + 80 * (Double(self.timeManager.duration).truncatingRemainder(dividingBy: 1)), weight: .thin, design: .monospaced))
                        .font(.custom("DBLCDTempBlack", size: s))
                        .fontWeight(.thin)
                        .lineLimit(1)
                        .padding()
                        .foregroundColor(Color.red)//.opacity(Double(13 * self.timeManager.duration / self.timeManager.maxValue).truncatingRemainder(dividingBy: 1) + 0.1)
                }
            }
        }
        //毎0.05秒ごとに発動
//        .onReceive(timeManager.timer) { _ in
//
//            if self.timeManager.timerStatus == .stopped {
//                self.costomHueA += 0.0025
//                self.costomHueB += 0.005
//                self.costomHueRunningA = 0.0
//                self.costomHueRunningB = 0.0
//            } else {
//                if self.timeManager.duration < 5 {
//                    self.costomHueRunningA += 0.05
//                    self.costomHueRunningB += 0.05
//                } else {
//                    self.costomHueRunningA += CGFloat( 0.05 / self.timeManager.maxValue)
//                    self.costomHueRunningB += CGFloat( 0.05 / self.timeManager.maxValue)
//                }
//                self.costomHueA = costomHueRunningA
//                self.costomHueB = costomHueRunningB
//            }
//            print(costomHueA, costomHueB)
//            if self.costomHueA >= 1.0 {
//                self.costomHueA = 0.0
//                self.costomHueRunningA = 0.0
//            }
//            if self.costomHueB >= 1.0 {
//                self.costomHueB = 0.0
//                self.costomHueRunningB = 0.0
//            }
//        }
    }
    
//    func makeGradientColor(hueA: Double, hueB: Double) -> AngularGradient {
//        let colorA = Color(hue: hueA, saturation: 0.75, brightness: 0.9)
//        let colorB = Color(hue: hueB, saturation: 0.75, brightness: 0.9)
//        let gradient = AngularGradient(gradient: .init(colors: [colorA, colorB, colorA]), center: .center, startAngle: .zero, endAngle: .init(degrees: 360))
//        return gradient
//    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}

