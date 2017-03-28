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
        case B
        
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
            case .B:
                return "B"
            }
        }
    }
    
    public static var none:Note?
}


public class PlaygroundPlayer {
    public static let shared = PlaygroundPlayer()
    fileprivate var players = [String:AVAudioPlayer]()
    private var runLoopTimer:Timer?
    
    private var playTime:TimeInterval = 1.0
    private var playingStack = [[Note]]()
    
    
    public var isPlaying:Bool {
        get {
            return players.reduce(0, { (result, object) -> Int in
                return result + (object.value.isPlaying ? 1 : 0)
            }) != 0
        }
    }
    
    public func setupPlayer(notes:[[Note]]) {
        playingStack = notes
        initPlayers(notes: playingStack)
    }
    
    @objc public func play(`repeat`:Bool = false) {
        playNotes(notes: playingStack, repeat:`repeat`)
    }
    
    public func playNotes(notes:[[Note]], `repeat`:Bool = false) {
        playingStack = notes
        
        self.runLoopTimer = Timer.scheduledTimer(withTimeInterval: playTime, repeats: true) { (timer) in
            if let players = self.playingStack.first {
                print("Playing \(players)")
                players.forEach({ (note) in
                    if let player = self.players[note.filename()] {
                        if player.isPlaying {
                            player.currentTime = 0.0
                        }
                        player.play()
                    }
                })
                
                //players.forEach({self.players[$0.filename()]?.play()})
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

