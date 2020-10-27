//
//  Data.swift
//  Qiita_Timer
//
//  Created by masanao on 2020/10/15.
//

import SwiftUI
import AudioToolbox

enum TimeFormat {
    case hr
    case min
    case sec
}

enum TimerStatus {
    case running
    case pause
    case stopped
}

struct Sound: Identifiable {
    let id: SystemSoundID
    let soundName: String
}
