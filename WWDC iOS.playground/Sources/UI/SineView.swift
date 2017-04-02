import Foundation
import UIKit

public class SineWaveView: UIView {
    public var amplitude:CGFloat = 0.2
    
    private var idleAmplitude:CGFloat = 0.3
    private var phase:CGFloat = 0.0
    
    private var frequency:CGFloat = 1.5
    private var dampingFactor:CGFloat = 0.86
    
    private var waves:Int = 6
    private var waveWidth:CGFloat = 2.0
    
    private var dampingAmplitude:CGFloat = 1.0
    
    private var density:CGFloat = 8
    
    public var phaseShift:CGFloat = -0.15
    
    private var maxAmplitude:CGFloat = 0.4
    
    private let fps:TimeInterval = 55
    
    public var updateRate:TimeInterval {
        get {
            return 1.0 / fps
        }
    }
    
    public func update(level:CGFloat) {
        if level > dampingAmplitude {
            dampingAmplitude += (min(level, 1.0) - dampingAmplitude) / 4.0
        } else if level < 0.01 {
            dampingAmplitude *= dampingFactor
        }

        phase += phaseShift
        amplitude = max(min(dampingAmplitude * 40, 1.0), idleAmplitude)
        refresh()
    }
    
    public override func draw(_ rect: CGRect) {
        let drawLine = { (index:Int, maxAmplitude:CGFloat, normedAmplitude:CGFloat, size:CGSize) in
            let path = UIBezierPath()
            let mid = self.bounds.width/2.0
            
            path.lineWidth = self.waveWidth
            
            for x in stride(from:0, to:self.bounds.width + self.density, by:self.density) {
                // Parabolic scaling
                let scaling = -pow(1 / mid * (x - mid), 2) + 1
                let y = scaling * maxAmplitude * normedAmplitude * sin(CGFloat(2 * M_PI) * (x / rect.size.width) * self.frequency + self.phase) + rect.size.height / 2.0
                if x == 0 {
                    path.move(to: CGPoint(x:x, y:y))
                } else {
                    path.addLine(to: CGPoint(x:x, y:y))
                }
            }
            path.stroke()
        }
        
        let context = UIGraphicsGetCurrentContext()
        context?.setAllowsAntialiasing(true)
        
        self.backgroundColor?.set()
        context?.fill(rect)
        
        let halfHeight = self.bounds.height / 2.0
        let maxAmplitude = halfHeight * self.maxAmplitude - 4
        
        let colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.violet]
        
        for i in 0 ..< waves {
            let progress = 1.0 - CGFloat(i) / CGFloat(waves)
            let normedAmplitude = (1.5 * progress - 0.5) * self.amplitude
            let multiplier:CGFloat = fmin(1.0, (progress / 3.0 * 2.0) + (1.0/3.0))
            colors[i].withAlphaComponent(multiplier).set()
            drawLine(i, maxAmplitude, normedAmplitude, bounds.size)
        }
        self.phase += self.phaseShift
    }
    
    public func refresh() {
        self.setNeedsDisplay()
    }
}
