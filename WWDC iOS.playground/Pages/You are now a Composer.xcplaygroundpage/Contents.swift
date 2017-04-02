import UIKit
import PlaygroundSupport

let playgroundController = PlaygroundViewController()
playgroundController.isTutorial = false
PlaygroundPage.current.liveView = playgroundController
PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ## Becoming a Pro
 
 You are almost a complete **composer**!
 But in every melody, there should be the time for our ears to rest and prepare for new pleasure sounds. That's why we have a `Sound.Tone` which is called **none** (pretty cool name, isn't it?)
 
 You can use sounds, which we created [here](@previous) but add **rest sound** in the middle
 - Example: Rest *sound*\
 `let rest = Sound(instrument: Sound.Instrument.piano, tone: Sound.Tone.none)`
*/
// let rest = Sound(instrument: Sound.Instrument.piano, tone: <#Sound.Tone.none#>)
// let sounds = [sound1, rest, <#your unique sounds#>]
// let soundPlayer = SoundPlayer(sounds: [sounds])
/*:
 Now let's make our music *Swift-ier* :) \
 We will use `map()` function to combine our `instrument` and `tunes` \
 Here is the deal:
 - Example: Rest *sound*\
 `let instrument = Sound.Instrument.piano`\
 `let tunes:[Sound.Tone] = [.C, .D, .F, .D, .G, .F, .F, .D] // my favorite one`\
 `let sounds:[Sound] = tunes.map({Sound(instrument: instrument, tone: $0)})`
 
 I'm sure you remember how to play sounds, but you may also look up from the [previous](@previous) lesson
 */
// let instrument = <#Sound.Instrument#>
// let tunes:[Sound.Tone] = [.C, .D, <#continue...#>]
// let sounds:[Sound] = tunes.map({Sound(instrument: instrument, tone: $0)})
//:## Congratulations!
//:Now you are a real **music composer**! Have fun __*Playing*__ with sequence of `Sound.Tone`'s, changing the `Sound.Instrument`'s of even __mixing them up together__!
