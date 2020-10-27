//
//  TimerManager.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/15.
//

import SwiftUI

class TimeManager: ObservableObject {
    //Pickerで設定した"時間"を格納する変数
    @Published var hourSelection: Int = 0
    //Pickerで設定した"分"を格納する変数
    @Published var minSelection: Int = 0
    //Pickerで設定した"秒"を格納する変数
    @Published var secSelection: Int = 0
    //カウントダウン残り時間
    @Published var duration: Double = 0
    //カウントダウン開始前の最大時間
    @Published var maxValue: Double = 0
    //設定した時間が1時間以上、1時間未満1分以上、1分未満1秒以上によって変わる時間表示形式
    @Published var displayedTimeFormat: TimeFormat = .min
    
    //
    func setTimer() {
        duration = Double(hourSelection * 3600 + minSelection * 60 + secSelection)
        maxValue = duration
        
        if duration < 60 {
            displayedTimeFormat = .sec
        } else if duration < 3600 {
            displayedTimeFormat = .min
        } else {
            displayedTimeFormat = .hr
        }
        
        // add below later
//        if duration != 0 {
//            timerStatus = .pause
//        }
    }
    
    //カウントダウン中の残り時間を表示するためのメソッド
    func displayTimer() -> String {
        //
        let hr = Int(duration) / 3600
        let min = Int(duration) % 3600 / 60
        let sec = Int(duration) % 3600 % 60
        
        switch displayedTimeFormat {
        case .hr:
            return String(format: "%02d:%02d:%02d", hr, min, sec)
        case .min:
            return String(format: "%02d:%02d", min, sec)
        case .sec:
            return String(format: "%02d", sec)
        }
    }
}
