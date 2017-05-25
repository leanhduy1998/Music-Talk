//
//  PlayViewController.swift
//  Music Talk
//
//  Created by Duy Le on 5/14/17.
//  Copyright © 2017 Andrew Le. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController, AVAudioRecorderDelegate {
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    let halfTheAmount = 0.5
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    private enum ButtonType: Int{case slow=0,fast,chip,vader,echo,reverb}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAudio()
        configureUI(.notPlaying)
       
        
    }
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
             playSound(rate: Float(halfTheAmount))
        case .fast:
            playSound(rate: 1 + Float(halfTheAmount))
        case .chip:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }

}
