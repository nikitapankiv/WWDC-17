//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let instrument = Note.Instrument.piano


let note = Note(instrument: Note.Instrument.piano, tone: Note.Tone.D)
let sound = Sound(note: note, len: Sound.Length.medium)

let tunes:[Note.Tone] = [.B, .D, .A, .B, .D, .A]

let sounds:[[Note]] = tunes.map({[Note(instrument: instrument, tone: $0)]})

PlaygroundPlayer.shared.setupPlayer(notes: sounds)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundViewController()
