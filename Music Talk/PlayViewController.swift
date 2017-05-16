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
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    private enum ButtonType: Int{case bidoof=0,andrew,vader,chinese}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAudio()
        configureUI(.notPlaying)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .bidoof:
             playSound(rate: 1, pitch: -300, echo: false, reverb: true)
        case .andrew:
            playSound(rate: 1, pitch: 600, echo: false, reverb: false)
        
        case .vader:
            playSound(rate: 0.8, pitch: -1000, echo: false, reverb: false)
        case .chinese:
            playSound(rate: 2, pitch: 1000, echo: true, reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
