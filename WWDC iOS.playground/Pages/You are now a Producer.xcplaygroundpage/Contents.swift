import UIKit
import PlaygroundSupport

let instrument = Sound.Instrument.piano
let tunes:[Sound.Tone] = [.A, .F,
                         .A, .none, .F,
                         .A, .C, .F, .none,
                         .A, .D, .C]

let sounds:[Sound] = tunes.map({Sound(instrument: instrument, tone: $0)})

let player = SoundPlayer(notes: sounds, playTime:1.5)

PlaygroundPlayer.shared.setup(withPlayers: [player])

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundViewController()
