import PlaygroundSupport
import Foundation

let playgroundController = PlaygroundViewController()
playgroundController.isTutorial = false
PlaygroundPage.current.liveView = playgroundController
PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ## Playing
 
 Let's play. Copy-paste array of sounds previously created [here](@previous)\
 For playing you'll need a `SoundPlayer` \
 `SoundPlayer` is a simple player, which playes `Note`s in selected `Instrument`, that's it.\
 It accepts an `Array` of `Sound`s, but also optionally asks if you want to `repeat` the melody.
 - Example: Creating `SoundPlayer`\
 `let sound1 = Sound(instrument: Sound.Instrument.piano, tone: Sound.Tone.C)`\
 `let sound2 = Sound(instrument: Sound.Instrument.piano, tone: Sound.Tone.F)`\
 `let sounds = [sound1, sound2]`\
 `let soundPlayer = SoundPlayer(sounds: sounds)`
 */
//let soundPlayer = SoundPlayer(sounds: [<#notesArray#>], repeats: <#repeats#>)
/*:
 Now, you've created a `SoundPlayer`, but you may wonder why there is no **sound**?\
 So here is the deal, there is another class, called `PlaygroundPlayer`, it has a functionality to take an array of players (but now we will use only *one*) and make some magic, here is an example:
 - Example: *Magic*\
 `PlaygroundPlayer.shared.setup(withPlayers: [soundPlayer])`
 */
// PlaygroundPlayer.shared.setup(withPlayers: [<#soundPlayer#>])
/*:
 *Last*, but not **least** \
 I am sure you've noticed a new button called __Play__, now you have a chance to try it out :)\
 
 When you are ready, let's continue to explore even more interesting things!
 
 [I'm ready!](@next)
 */
