import Foundation
import UIKit

public class PlaygroundViewController: UIViewController {    
    private var updateTimer:Timer?
    private var sineView:SineWaveView?
    private var playButton:UIButton?
    
    public var isTutorial:Bool = false

    private var isPlaying:Bool = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // Setup Sine View
        let sineView = SineWaveView()
        self.sineView = sineView
        sineView.backgroundColor = UIColor.white
        view.addSubview(sineView)
        updateTimer = Timer.scheduledTimer(withTimeInterval: sineView.updateRate, repeats: true) { [unowned self] (timer) in
            self.sineView?.update(level: PlaygroundPlayer.shared.currentAmplitude)
        }
        
        // Setup Play Button
        let button = UIButton()
        self.playButton = button        
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = Colors.red.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 8.0
        button.setTitleColor(Colors.red, for: .normal)
        button.addTarget(PlaygroundViewController.playPressed, action: #selector(playPressed), for: .touchUpInside)
        button.isHidden = isTutorial
        view.addSubview(button)
        
        // Setup Label
        let textLabel = UILabel()
        textLabel.text = "MAKE OWN MUSIC "
        textLabel.textColor = UIColor.black
        textLabel.font = UIFont.boldSystemFont(ofSize: 22)
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        
        // Constraints
        let views = ["sineView":sineView, "button":button, "label":textLabel]
        views.forEach({$0.value.translatesAutoresizingMaskIntoConstraints = false})
        
        let constraints = ["V:[sineView(200)]-100-|",
                           "H:|[sineView]|",
                           "V:[button(30)]-22-|",
                           "H:|-42-[button]-42-|",
                           "V:|-16-[label]",
                           "H:|-8-[label]-8-|"]
        
        constraints.forEach({self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: views))})
    }
    
    public func playPressed(sender:UIButton?) {
        isPlaying = !isPlaying
        
        if isPlaying {
            PlaygroundPlayer.shared.play()
            sender?.setTitle("Stop", for: .normal)
        } else {
            PlaygroundPlayer.shared.stop()
            sender?.setTitle("Play", for: .normal)
        }
    }
    
}
