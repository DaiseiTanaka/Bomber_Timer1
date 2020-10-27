//
//  SettingView.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/21.
//

import SwiftUI

struct SettingView: View {
    //モーダルを利用するためのプロパティ
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var timeManager: TimeManager
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Alarm:")) {
                    Toggle(isOn: $timeManager.isAlarmOn) {
                        Text("Alarm Sound")
                    }
                    Toggle(isOn: $timeManager.isVibrationOn) {
                        Text("Vibration")
                    }
                    //サウンド選択画面へ画面遷移
                    NavigationLink(destination: SoundListView()) {
                        HStack {
                            //設定項目名
                            Text("Sound Selection")
                            Spacer()
                            //現在選択中のアラーム音
                            Text("\(timeManager.soundName)")
                        }
                    }
                }
                Section(header: Text("Animation:")) {
                    Toggle(isOn: $timeManager.isProgressBarOn) {
                        Text("Progress Bar")
                    }
                    Toggle(isOn: $timeManager.isEffectAnimationOn) {
                        Text("Effect Animation")
                    }
                }
                Section(header: Text("Save:")) {
                    Button(action: {
                        //モーダルを閉じる
                        self.presentationMode.wrappedValue.dismiss()
                        //debug
                        print(self.timeManager.isSetting)
                    }) {
                        HStack {
                            Spacer()
                            Text("Done")
                            Image(systemName: "checkmark.circle")
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("Setting", displayMode: .automatic)
            .navigationViewStyle(DefaultNavigationViewStyle())
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(TimeManager())
    }
}
