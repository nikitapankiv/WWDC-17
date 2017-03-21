//: Playground - noun: a place where people can play

import UIKit

import PlaygroundSupport

let sineView = SineWaveView(frame: CGRect(x: 0, y: 0, width: 500, height: 200))
sineView.backgroundColor = .white

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = sineView
