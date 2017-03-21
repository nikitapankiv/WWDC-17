import Foundation



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
    
    public enum Instrument {
        case piano
        case flute
        case pad
    }
    
    public enum Tone {
        case one
        case two
        case three
    }
    
    public static var none:Note?
}
