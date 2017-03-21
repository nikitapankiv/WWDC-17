import Foundation
import UIKit

public class SineWaveView: UIView {
    
    var lineColor:UIColor = .white
    
    var idleAmplitude:CGFloat = 0.0
    var phase:CGFloat = 0.0
    
    var frequency:CGFloat = 2.5
    var dampingFactor:CGFloat = 0.86
    
    var waves:CGFloat = 4.0
    var waveWidth:CGFloat = 1.0
    
    public var amplitude:CGFloat = 1.2
    
    var dampingAmplitude:CGFloat = 1.0
    
    var density:CGFloat = 7
    
    public var phaseShift:CGFloat = -0.15
    
    var whiteValue:CGFloat = 1.0
    
    var oscillating:Bool = true
    
    var maxAmplitude:CGFloat = 0.9
    
    var waveInsets:UIEdgeInsets = .zero
    
    public func update(level:CGFloat) {
        if level > dampingAmplitude {
            dampingAmplitude += (min(level, 1.0) - dampingAmplitude) / 4.0
        } else if level < 0.01 {
            dampingAmplitude *= dampingFactor
        }
        
        phase += phaseShift
        amplitude = max(min(dampingAmplitude * 20, 1.0), idleAmplitude)
        
        refresh()
    }
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        var frame = self.bounds
        backgroundColor?.set() // Set background color
        UIRectFill(frame)
        
        UIColor.white.set() // Line color
        frame = UIEdgeInsetsInsetRect(bounds, waveInsets)
        
        for i in 0...Int(waves) {
            let context = UIGraphicsGetCurrentContext()
            
            context?.setLineWidth(i == 0 ? waveWidth : 1.0)
            
            let halfheight = frame.size.height / 2
            let width = frame.size.width
            let mid = width / 2.0
            
            let maxAmplitude = halfheight * self.maxAmplitude - 4 // Modify 4
            
            let progress = 1.0 - CGFloat(i) / waves
            let normedAmplitude = (1.5 * progress - 0.5) * self.amplitude
            let multiplier = min(1.0 , (progress / 3.0 * 2.0) + (1.0 / 3.0))
            
            lineColor.withAlphaComponent(multiplier).set()
                    
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