//: Playground - noun: a place where people can play

import UIKit
import CoreMIDI
import AVFoundation


import PlaygroundSupport

let sineView = SineWaveView(frame: CGRect(x: 0, y: 0, width: 500, height: 100))

//let timer = Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { (timer) in
//    
//    var level:CGFloat = CGFloat(arc4random_uniform(100)) / 100.0 // normalized
//    
//    if arc4random_uniform(2) == 1 {
//        level = 0
//    }
//    
//    sineView.update(level: level)
//}

let sound = Sound(note: Note(instrument: .piano, tone: .one), len: .medium)

let delayTime = 0.4

var firstPlayer:AVAudioPlayer!
var secondPlayer:AVAudioPlayer!


if let path = Bundle.main.path(forResource: "1", ofType: "wav"), let url = URL(string:path) {
    if let player = try? AVAudioPlayer(contentsOf: url) {
        firstPlayer = player
        player.prepareToPlay()
    }
}


if let path = Bundle.main.path(forResource: "2", ofType: "wav"), let url = URL(string:path) {
    if let player = try? AVAudioPlayer(contentsOf: url) {
        secondPlayer = player
        player.prepareToPlay()
    }
}

var stack:[[AVAudioPlayer]] = [[firstPlayer], [firstPlayer], [firstPlayer,secondPlayer], [secondPlayer]]


let firstTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
    if let players = stack.first {
        print("Playing \(players)")
        players.forEach({$0.play()})
        stack = Array(stack.dropFirst())
    } else {
        timer.invalidate()
    }
}

let secondTimer = Timer.scheduledTimer(withTimeInterval: 1.7, repeats: true) { (timer) in
    if let players = stack.first {
        players.forEach({$0.prepareToPlay()})
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = sineView

