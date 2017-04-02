import Foundation
import AVFoundation

public class PlaygroundPlayer {
    public static let shared = PlaygroundPlayer()
    
    private var players = [SoundPlayer]()
    
    public var isPlaying:Bool {
        get {
            return players.reduce(0, { (result, object) -> Int in
                return result + (object.isPlaying ? 1 : 0)
            }) != 0
        }
    }
    
    public var currentAmplitude:CGFloat {
        get {
            return isPlaying ? 0.7 : 0.0
        }
    }
    
    public func setup(withPlayers players:[SoundPlayer]) {
        self.players = players
    }
    
    public func play() {
        players.forEach({$0.play()})
    }
    
    public func stop() {
        players.forEach({$0.stop()})
    }
    
}

public class SoundPlayer {
    
    private var players = [String:AVAudioPlayer]()
    private var runLoopTimer:Timer?
    
    private var playingStack = [[Sound]]()
    
    private var playTime:TimeInterval = 0.5
    private var repeats:Bool
    
    public init(sounds:[Sound], repeats:Bool = false) {
        self.repeats = repeats
        
        setupPlayer(sounds: sounds)
    }
    
    public var isPlaying:Bool {
        get {
            return players.reduce(0, { (result, object) -> Int in
                return result + (object.value.isPlaying ? 1 : 0)
            }) != 0
        }
    }
    
    public func play() {
        playSounds(sounds: playingStack)
    }
    
    public func stop() {
        runLoopTimer?.invalidate()
        players.forEach({$0.value.stop()})
    }

    //MARK: - Setup
    
    private func setupPlayer(sounds:[[Sound]]) {
        playingStack = sounds
        initPlayers(sounds: playingStack)
    }
    
    private func setupPlayer(sounds:[Sound]) {
        let morphedNotes = sounds.map({[$0]})
        setupPlayer(sounds: morphedNotes)
        
    }
    
    //MARK: - Playing
    
    private func playSounds(sounds:[[Sound]]) {
        var playingSounds = playingStack
        
        self.runLoopTimer = Timer.scheduledTimer(withTimeInterval: playTime, repeats: true) { (timer) in
            
            let play:(([Sound])->Void) = { (sounds) in
                sounds.forEach({ (sound) in
                    if let player = self.players[sound.filename()] {
                        if player.isPlaying {
                            player.currentTime = 0.0
                        }
                        player.play()
                    }
                })
            }
            
            if let players = playingSounds.first {
                play(players)
                playingSounds = Array(playingSounds.dropFirst())
            } else {
                if self.repeats {
                    playingSounds = self.playingStack
                    
                    if let players = playingSounds.first {
                        play(players)
                        playingSounds = Array(playingSounds.dropFirst())
                    }
                } else {
                    timer.invalidate()
                }
            }
        }
    }
    
    //MARK: - Support Methods
    
    private func initPlayers(sounds:[[Sound]]) {
        self.playingStack = sounds
        
        sounds.flatMap({$0}).forEach { (sound) in
            if sound.tone != Sound.Tone.none && players[sound.filename()] == nil {
                if let player = createPlayer(sound: sound) {
                    players[sound.filename()] = player
                }
            }
        }
    }

    private func createPlayer(sound:Sound) -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: sound.filename(), ofType: "wav"), let url = URL(string:path) {
            if let player = try? AVAudioPlayer(contentsOf: url) {
                player.prepareToPlay()
                
                return player
            }
        }
        
        return nil
    }
    
}
