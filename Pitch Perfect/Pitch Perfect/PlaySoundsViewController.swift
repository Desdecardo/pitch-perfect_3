//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Phil Feinstein on 3/29/15.
//  Copyright (c) 2015 Phil Feinstein. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

        var Audioplayer:AVAudioPlayer!
        var receivedAudio:RecordedAudio!
        var audioEngine: AVAudioEngine!
        var audioFile:AVAudioFile!
        @IBOutlet weak var HideStop: UIButton!

override func viewWillAppear(animated: Bool) {
        HideStop.hidden = true
    }
    
override func viewDidLoad() {
        super.viewDidLoad()
        
        Audioplayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        Audioplayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }
    
override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
    }
    
func playAudioWithVariablePitch(pitch: Float){
        
            Audioplayer.stop()
            audioEngine.stop()
            audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
            audioEngine.attachNode(changePitchEffect)
            audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
            audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            audioEngine.startAndReturnError(nil)
            audioPlayerNode.play()
    }
    
//button that plays audio slowly
@IBAction func SlowPlay(sender: UIButton) {
            HideStop.hidden = false
            Audioplayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            Audioplayer.currentTime = 0.0
            Audioplayer.rate = 0.5
            Audioplayer.play()
    }
    
//button that plays audio at 2x speed
@IBAction func FastPlay(sender: UIButton) {
            HideStop.hidden = false
            Audioplayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            Audioplayer.currentTime = 0.0
            Audioplayer.rate = 2.0
            Audioplayer.play()
    }
    
//button that stops all playback
@IBAction func AllStop(sender: AnyObject) {
            Audioplayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            HideStop.hidden = true
    }
    
// high pitch for "Chipmunk"
@IBAction func playChipmunkAudio(sender: UIButton) {
            HideStop.hidden = false
            Audioplayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            Audioplayer.currentTime = 0.0
            playAudioWithVariablePitch(1000)
    }
    
// low pitch for "Darth Vader"
@IBAction func playVaderAudio(sender: UIButton) {
            HideStop.hidden = false
            Audioplayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            Audioplayer.currentTime = 0.0
            playAudioWithVariablePitch(-800)
    }
    }
