import Foundation
import UIKit


public class PlaygroundViewController: UIViewController {
    
    var updateTimer:Timer?
    var sineView:SineWaveView?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        print(view.frame.size.width)
        
        let sineView = SineWaveView(frame: CGRect(x: 0, y: 0, width: 700, height: 200))
        self.sineView = sineView
        sineView.maxAmplitude = 0.3
        sineView.backgroundColor = UIColor.white
        sineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sineView)
        
        updateTimer = Timer.scheduledTimer(withTimeInterval: sineView.updateRate, repeats: true) { [unowned self] (timer) in
            
            let level:CGFloat = CGFloat(arc4random_uniform(100)) / 100.0 // normalized
            //self.sineView?.update(level: level)
            self.sineView?.update(level:1.0)
        }
        
        let button = UIButton(frame: CGRect(x: 0, y: 50, width: 80, height: 20))
        button.setTitle("Hello", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(PlaygroundViewController.playPressed, action: #selector(playPressed), for: .touchUpInside)
        view.addSubview(button)
        
        
        let textLabel = UILabel()
        textLabel.text = " WWDC 2017"
        textLabel.textColor = UIColor.black
        textLabel.font = UIFont.boldSystemFont(ofSize: 22)
        textLabel.textAlignment = .center
        
        view.addSubview(textLabel)
        
        let views = ["sineView":sineView, "button":button, "label":textLabel]
        views.forEach({$0.value.translatesAutoresizingMaskIntoConstraints = false})
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[sineView(100)]-100-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[sineView]-8-|", options: [], metrics: nil, views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button(44)]-22-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[button]-8-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[label]", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[label]-8-|", options: [], metrics: nil, views: views))

    }
    
    public func playPressed() {
        sineView?.maxAmplitude = 0.7
        PlaygroundPlayer.shared.play()
    }
    
}
