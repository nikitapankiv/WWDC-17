import Foundation
import AVFoundation

public struct Sound {
    let note:Note
    let len:Length
    
    public init(note:Note, len:Length) {
        self.note = note
        self.len = len
    }
    
    public enum Length {
        case short
        case medium
        case long
    }
}

public struct Note {
    let instrument:Instrument
    let tone:Tone
    
    public init(instrument:Instrument, tone:Tone) {
        self.instrument = instrument
        self.tone = tone
    }
    
    public func filename() -> String {
        return tone.fileName()
    }
    
    public enum Instrument {
        case piano
        case flute
        case ocarina
        case pad
    }
    
    public enum Tone {
        case D
        case E
        case F
        case G
        case A
        case C
        
        public func fileName() -> String {
            switch self {
            case .D:
                return "D"
            case .E:
                return "E"
            case .F:
                return "F"
            case .G:
                return "G"
            case .A:
                return "A"
            case .C:
                return "C"
            }
        }
    }
    
    public static var none:Note?
}


public class PlaygroundPlayer {
    public static let shared = PlaygroundPlayer()
    fileprivate var players = [String:AVAudioPlayer]()
    private var runLoopTimer:Timer?
    
    private var playTime:TimeInterval = 1
    private var playingStack = [[Note]]()
    
    
    public func playNotes(notes:[[Note]], `repeat`:Bool = false) {
        playingStack = notes
        initPlayers(notes: playingStack)
        
        self.runLoopTimer = Timer.scheduledTimer(withTimeInterval: playTime, repeats: true) { (timer) in
            if let players = self.playingStack.first {
                print("Playing \(players)")
                players.forEach({self.players[$0.filename()]?.play()})
                self.playingStack = Array(self.playingStack.dropFirst())
            } else {
                if `repeat` {
                    self.playingStack = notes
                } else {
                    timer.invalidate()
                }
            }
        }
    }
    
    private func initPlayers(notes:[[Note]]) {
        let notes = notes.flatMap({$0})
        notes.forEach { (note) in
            if players[note.filename()] == nil {
                if let player = createPlayer(fileName: note.filename()) {
                    players[note.filename()] = player
                }
            }
        }
        
        print("Players initialized")
    }

//    public func playNote(note:Note) {
//        if let player = players[note.filename()] {
//            player.play()
//        } else {
//            if let player = createPlayer(fileName: note.filename()) {
//                self.players[note.filename()] = player
//                playNote(note: note)
//            } else {
//                return
//            }
//        }
//    }
    
    private func createPlayer(fileName:String) -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "wav"), let url = URL(string:path) {
            if let player = try? AVAudioPlayer(contentsOf: url) {
                player.prepareToPlay()
                
                return player
            }
        }
        
        return nil
    }
    
}

