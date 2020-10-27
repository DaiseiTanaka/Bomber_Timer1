//
//  TimerView.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/16.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timeManager: TimeManager

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
            } else if self.timeManager.displayedTimeFormat == .min {
                Text(self.timeManager.displayTimer())
                    .font(.system(size: self.screenWidth * 0.23, weight: .thin, design: .monospaced))
                    .lineLimit(1)
                    .padding()
                //表示形式が"秒"の場合
            } else {
                Text(self.timeManager.displayTimer())
                    .font(.system(size: self.screenWidth * 0.5, weight: .thin, design: .monospaced))
                    .lineLimit(1)
                    .padding()
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}
