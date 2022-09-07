//
//  ButtonsView.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/18.
//

import SwiftUI

struct ButtonsView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    var body: some View {
        HStack {
            //リセットボタン
            //Image(systemName: "stop.circle.fill")
            Image(systemName: "house.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
                //ボタンの左側とスクリーンの端にスペースをとる
                .padding(.leading)
                //タイマーステータスが終了なら透明度を0.1に、そうでなければ不透明に
                .opacity((self.timeManager.minSelection == 0 && self.timeManager.secSelection == 0 && self.timeManager.timerStatus == .stopped) ? 0.1 : 1)
                //ボタンをタップしたときのアクション
                .onTapGesture {
                    // debug
                    print(self.timeManager.timerStatus)
                    //タイマーステータスが.stopped以外の場合
                    if timeManager.timerStatus == .running || timeManager.timerStatus == .pause {
                        self.timeManager.reset()
                        //self.timeManager.duration = 0
                    } else {
                        self.timeManager.hourSelection = 0
                        self.timeManager.minSelection = 0
                        self.timeManager.secSelection = 0
                    }
                    self.timeManager.show = false
                    
                }
//                .fullScreenCover(isPresented: $timeManager.show) {
//                    MainView().environmentObject(self.timeManager)
//                }
            
            //ボタンとボタンの間隔をあける
            Spacer()
            
            //running: 一時停止ボタン/pause or stopped: スタートボタン
            Image(systemName: self.timeManager.timerStatus == .running ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
                //ボタンの右側とスクリーンの端にスペースをとる
                .padding(.trailing)
                //Pickerの時間、分、秒がいずれも0だったらボタンの透明度を0.1に、そうでなければ1（不透明）に
                .opacity(self.timeManager.hourSelection == 0 && self.timeManager.minSelection == 0 && self.timeManager.secSelection == 0 ? 0.1 : 1)
                //ボタンをタップした時のアクション
                .onTapGesture {
                    // debug
                    print(self.timeManager.timerStatus)
                    if timeManager.timerStatus == .stopped {
                        self.timeManager.setTimer()
                    }
                    //残り時間が0以外かつタイマーステータスが.running以外の場合
                    if timeManager.duration != 0 && timeManager.timerStatus != .running {
                        self.timeManager.start()
                        //タイマーステータスが.runningの場合
                    } else if timeManager.timerStatus == .running {
                        self.timeManager.pause()
                    }
                }
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}
