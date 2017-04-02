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
        sineView.backgroundColor = UIColor.white
        sineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sineView)
        
        updateTimer = Timer.scheduledTimer(withTimeInterval: sineView.updateRate, repeats: true) { [unowned self] (timer) in
            
            self.sineView?.update(level: PlaygroundPlayer.shared.currentAmplitude)
        }
        
        let button = UIButton(frame: CGRect(x: 0, y: 50, width: 80, height: 20))
        button.setTitle("Hello", for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 8.0
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(PlaygroundViewController.playPressed, action: #selector(playPressed), for: .touchUpInside)
        view.addSubview(button)
        
        
        let textLabel = UILabel()
        textLabel.text = "MAKE OWN MUSIC "
        textLabel.textColor = UIColor.black
        textLabel.font = UIFont.boldSystemFont(ofSize: 22)
        textLabel.textAlignment = .center
        
        view.addSubview(textLabel)
        
        let views = ["sineView":sineView, "button":button, "label":textLabel]
        views.forEach({$0.value.translatesAutoresizingMaskIntoConstraints = false})
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[sineView(200)]-100-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[sineView]|", options: [], metrics: nil, views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button(30)]-22-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-42-[button]-42-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[label]", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[label]-8-|", options: [], metrics: nil, views: views))

    }
    
    public func playPressed() {
        PlaygroundPlayer.shared.play()
    }
    
}
