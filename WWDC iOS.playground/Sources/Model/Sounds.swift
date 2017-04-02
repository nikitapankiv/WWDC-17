import Foundation

public struct Sound {
    let instrument:Instrument
    let tone:Tone
    
    public init(instrument:Instrument, tone:Tone) {
        self.instrument = instrument
        self.tone = tone
    }
    
    public func filename() -> String {
        return "\(instrument.instrumentName())_\(tone.fileName())"
    }
    
    public enum Instrument {
        case piano
        case organ
        case horn
        case tremolo
        
        public func instrumentName() -> String {
            switch self {
            case .piano:
                return "piano"
            case .organ:
                return "organ"
            case .horn:
                return "horn"
            case .tremolo:
                return "tremolo"
            }
        }
    }
    
    public enum Tone {
        case A
        case C
        case D
        case F
        case G
        
        case none
        
        public func fileName() -> String {
            switch self {
            case .D:
                return "D"
            case .F:
                return "F"
            case .G:
                return "G"
            case .A:
                return "A"
            case .C:
                return "C"
            case .none:
                return ""
            }
        }
    }
}

extension Sound: Equatable {
    public static func ==(lhs: Sound, rhs: Sound) -> Bool {
        return lhs.instrument == rhs.instrument && lhs.tone == rhs.tone
    }
}
