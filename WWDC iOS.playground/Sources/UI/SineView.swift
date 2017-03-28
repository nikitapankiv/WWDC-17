import Foundation
import UIKit

public class SineWaveView: UIView {
    
    public var lineColor:UIColor = .white
    
    var idleAmplitude:CGFloat = 0.0
    var phase:CGFloat = 0.0
    
    var frequency:CGFloat = 1.5
    var dampingFactor:CGFloat = 0.86
    
    var waves:CGFloat = 5.0
    var waveWidth:CGFloat = 2.0
    
    public var amplitude:CGFloat = 1.2
    
    var dampingAmplitude:CGFloat = 1.0
    
    var density:CGFloat = 8
    
    public var phaseShift:CGFloat = -0.15
    
    var whiteValue:CGFloat = 1.0
    
    var oscillating:Bool = false
    
    var maxAmplitude:CGFloat = 0.5
    
    var waveInsets:UIEdgeInsets = .zero
    
    public let fps:TimeInterval = 55
    
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
        amplitude = max(min(dampingAmplitude * 20, 1.0), idleAmplitude)
        //amplitude = max(level, idleAmplitude)
        
        refresh()
    }
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        var frame = self.bounds
        backgroundColor?.set() // Set background color
        UIRectFill(frame)
        
        lineColor.set() // Line color
        frame = UIEdgeInsetsInsetRect(bounds, waveInsets)
        
        let colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.violet]
        
        for i in 0...Int(waves) {
            let context = UIGraphicsGetCurrentContext()
            
            context?.setLineWidth(i == 0 ? waveWidth : 1.0)
            
            let halfheight = frame.size.height / 2
            let width = frame.size.width
            let mid = width / 2.0
            
            let maxAmplitude = halfheight * self.maxAmplitude - 4 //(self.maxAmplitude * 65) // Modify 4
            
            let progress = 1.0 - CGFloat(i) / waves
            let normedAmplitude = (1.5 * progress - 0.5) * self.amplitude
            let multiplier = min(1.0 , (progress / 3.0 * 2.0) + (1.0 / 3.0))
            
            colors[i].withAlphaComponent(multiplier).set()
            
            var x:CGFloat = 0
            
            while x < width + density {
                let scaling = -pow(1/mid * (x - mid), 2) + 1
                let y = scaling * maxAmplitude * normedAmplitude * sin(CGFloat(2 * M_PI) * (x / width) * frequency + phase) + halfheight
                
                let pointX = frame.minX + x
                let pointY = frame.minY + y
                
                if x == 0 {
                    context?.move(to: CGPoint(x: pointX, y: pointY))
                } else {
                    context?.addLine(to: CGPoint(x: pointX, y: pointY))
                }
                x += density
            }
            
            context?.strokePath()
            
        }
        context?.restoreGState()
    }
    
    public func refresh() {
        self.setNeedsDisplay()
    }
}
