import Foundation
import PlaygroundSupport

let playgroundController = PlaygroundViewController()
playgroundController.isTutorial = true
PlaygroundPage.current.liveView = playgroundController
PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ## Sound Basics
 
What is it? Typically, sound can be created of a __tone__ and the __instrument__. Here it is `Sound.Instrument` and `Sound.Tone`.
 - Example: I'm a **sound**\
`let simpleSound = Sound(instrument: Sound.Instrument.piano, tone: Sound.Tone.C)`
*/
//let simpleSound = Sound(instrument: <#T##Sound.Instrument#>, tone: <#T##Sound.Tone#>)
/*:
In this playground, we want to create a melody, so, melody is a _sequence_ of sounds, in this particular way an `Array` of `Sound`'s
 
 - Example: Creating *sequence* of sounds\
 `let sound1 = Sound(instrument: Sound.Instrument.piano, tone: Sound.Tone.C)`\
 `let sound2 = Sound(instrument: Sound.Instrument.piano, tone: Sound.Tone.F)`\
 `let sounds = [sound1, sound2]`
*/
// let secondSimpleSound = <#Sound#>
// let sounds:[Sound] = [simpleSound, secondSimpleSound]
/*:
 Now, you are accustomed to basic sound theory and you are ready to **play**! \
 [Yes!](@next)
*/
