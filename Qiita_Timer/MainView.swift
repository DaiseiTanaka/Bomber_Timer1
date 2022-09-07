//
//  MainView.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/16.
//

import SwiftUI
import UIKit
import AudioToolbox
import AVFoundation
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}

struct MainView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @EnvironmentObject var timeManager: TimeManager
    @State var viewHeight: CGFloat = UIScreen.main.bounds.height
    @State var viewWidth: CGFloat = UIScreen.main.bounds.width
    
    //private var explosion = try!  AVAudioPlayer(data: NSDataAsset(name: "''")!.data)
    private let clock = try!  AVAudioPlayer(data: NSDataAsset(name: "clock2")!.data)
    //private let fire = try!  AVAudioPlayer(data: NSDataAsset(name: "fireLine")!.data)
    private func playSound(){
        print("Sound name: \(self.timeManager.soundName)")
        if self.timeManager.soundName == "Bomber" {
            let explosion = try!  AVAudioPlayer(data: NSDataAsset(name: self.timeManager.soundName)!.data)
            explosion.stop()
            explosion.currentTime = 0.0
            explosion.play()
        } else {
            AudioServicesPlayAlertSoundWithCompletion(self.timeManager.soundID, nil)
        }
    }
    
    private func clockPlay(rate: Float) {
        clock.enableRate = true
        clock.rate = rate
        clock.stop()
        clock.currentTime = TimeInterval(80)
        clock.play()
        print("playing clock as rate: ", rate)
    }
    
//    private func fireLine() {
//        fire.stop()
//        fire.currentTime = 0.0
//        fire.play()
//    }
//
    var body: some View {
        
        ZStack {
            //NavigationView {
            if UIDevice.current.userInterfaceIdiom == .phone {
                Text("Bomber Timer")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .fontWeight(.heavy)
                    .opacity((self.timeManager.show != true && self.timeManager.timerStatus == .stopped) ? 1 : 0)
                    .offset(x: 0, y: -viewHeight * 0.38)
                BannerView()
                    .frame(height: 60)
                    .offset(x: 0, y: -viewHeight * 0.32)
                BannerView()
                    .frame(height: 60)
                    .offset(x: 0, y: viewHeight * 0.35)

            } else if UIDevice.current.userInterfaceIdiom == .pad {
                Text("Bomber Timer")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .fontWeight(.heavy)
                    .opacity((self.timeManager.show != true && self.timeManager.timerStatus == .stopped) ? 1 : 0)
                    .offset(x: 0, y: -viewHeight * 0.55)
                VStack {
                    BannerView()
                        .frame(height: 60)
                    Spacer()
                }

            }
            if timeManager.isEffectAnimationOn && timeManager.timerStatus != .stopped {
                //AnimationView()
            }
            
            if timeManager.isProgressBarOn {
                ProgressBarView()
            }
            
            if timeManager.timerStatus == .stopped {
                if self.timeManager.show == true {
                    TimeOverView()
                        .onAppear {
                            print("time over view opend")
                        }
                        .onDisappear {
                            print("time over view closed")
                        }
                } else {
                    PickerView()
                        .padding(.horizontal)
                }
            } else {
                
                TimerView()
            }
            
            //            if timeManager.duration < 5.0 && timeManager.timerStatus == .running {
            //                Color.red.opacity(1 - timeManager.duration / timeManager.maxValue)
            //            }
            
            VStack {
                Spacer()
                
                
                if UIDevice.current.orientation.isPortrait && UIDevice.current.userInterfaceIdiom == .pad {
                    BannerView()
                        .frame(height: 60)
                        .padding()
                    ButtonsView()
                        .padding(.bottom)
                } else {
                    ButtonsView()
                        //.padding(.bottom)
                }
                
                
                //設定ボタンを追加
                SettingButtonView()
                    .padding(.bottom)
               // isSettingプロパティがtrueになったらSettingViewをモーダルで表示
                    .sheet(isPresented: $timeManager.isSetting) {
                        SettingView()
                            .environmentObject(self.timeManager)
                    }
            }
        }
        .onAppear {
            
        }
        .ignoresSafeArea()
        //指定した時間（1秒）ごとに発動するtimerをトリガーにしてクロージャ内のコードを実行
        .onReceive(timeManager.timer) { _ in
            //タイマーステータスが.running以外の場合何も実行しない
            guard self.timeManager.timerStatus == .running else {
                clock.stop()
                //                if self.timeManager.duration > 0 {
                //                    self.timeManager.show = true
                //                }
                return
                
            }
            //残り時間が0より大きい場合
            if self.timeManager.duration > 0 {
                //残り時間から -0.05 する
                self.timeManager.duration -= 0.05
                
                if self.timeManager.duration < 2 && self.timeManager.duration > 1.95 {
                    //clock.volume = 1
                    clockPlay(rate: 4.0)
                }
                else if self.timeManager.duration < 6 && self.timeManager.duration > 5.95 {
                    clockPlay(rate: 2.0)
                }
                else if self.timeManager.duration < 10 && self.timeManager.duration > 9.95 {
                    clockPlay(rate: 1.0)
                }
                
                //バイブレーション
                if self.timeManager.duration > 10 && self.timeManager.duration <= 60 {
                    if timeManager.isVibrationOn {
                        AudioServicesPlaySystemSound( 1520 )
                    }
                }
                if self.timeManager.duration <= 10 {
                    if timeManager.isVibrationOn {
                        AudioServicesPlaySystemSound( kSystemSoundID_Vibrate )
                    }
                }
                
            } else {
                self.timeManager.show = true
                //タイマーステータスを.stoppedに変更する
                self.timeManager.timerStatus = .stopped
                //アラーム音を鳴らす
//                if timeManager.isAlarmOn {
//                    AudioServicesPlayAlertSoundWithCompletion(self.timeManager.soundID, nil)
//                }
                playSound()
                clock.stop()
                //バイブレーションを作動させる
                if timeManager.isVibrationOn {
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                }
                
            }
            // }
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView().environmentObject(TimeManager())
        }
    }
}
