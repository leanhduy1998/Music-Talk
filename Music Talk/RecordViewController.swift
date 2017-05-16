//
//  RecordViewController.swift
//  Music Talk
//
//  Created by Duy Le on 5/14/17.
//  Copyright © 2017 Andrew Le. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var recordingStatusLabel: UILabel!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var stopRecordBtn: UIButton!
  
    @IBOutlet weak var continueBtn: UIButton!
    
    private var audioRecorder: AVAudioRecorder!
    
    var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordBtn.isHidden = false
        stopRecordBtn.isHidden = true
        recordingStatusLabel.text = "Ready to Record"
        continueBtn.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func recordBtnPressed(_ sender: Any) {
        recordingStatusLabel.text = "Recording in progress"
        switchStartStopRecord()
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()

        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeReport(time:)), userInfo: nil, repeats: true);
        timer?.fire()
    }
    func timeReport(time: Int){
        recordingStatusLabel.text = "Recording in progress: " + String(Int(audioRecorder.currentTime))+"s"
    }
    @IBAction func stopRecordBtnPressed(_ sender: Any) {
        timer?.invalidate()
        recordingStatusLabel.text = "Please wait!"
        switchStartStopRecord()
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        
    }
    func switchStartStopRecord(){
        if recordBtn.isHidden == true {
            recordBtn.isHidden = false
            stopRecordBtn.isHidden = true
        }
        else {
            recordBtn.isHidden = true
            stopRecordBtn.isHidden = false
        }
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        recordingStatusLabel.text = "Ready to Record"
        continueBtn.isEnabled = true
    }
    @IBAction func continueBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "PlayViewController", sender: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayViewController {
            if audioRecorder.url.absoluteString.isEmpty || audioRecorder.url == nil {
                
            }
            else {
                destination.recordedAudioURL = audioRecorder.url
            }
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
