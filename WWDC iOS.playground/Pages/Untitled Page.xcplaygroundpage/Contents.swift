//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let sineView = SineWaveView(frame: CGRect(x: 0, y: 0, width: 700, height: 200))

let instrument = Note.Instrument.ocarina

let tunes:[Note.Tone] = [.D, .E, .F, .G, .A, .C, .D, .E, .F]

let sounds:[[Note]] = tunes.map({[Note(instrument: instrument, tone: $0)]})

//PlaygroundPlayer.shared.setupPlayer(notes: sounds)

let button = UIButton(frame: CGRect(x: 0, y: 50, width: 40, height: 20))
button.setTitle("Hello", for: .normal)
button.backgroundColor = UIColor.red
button.addTarget(PlaygroundPlayer.shared, action: #selector(PlaygroundPlayer.play), for: .touchUpInside)

sineView.addSubview(button)
sineView.backgroundColor = UIColor.white

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = sineView

let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in

    var level:CGFloat = CGFloat(arc4random_uniform(100)) / 100.0 // normalized
    sineView.update(level: 0.1)
}
