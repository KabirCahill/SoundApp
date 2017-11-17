//
//  RecordViewController.swift
//  SoundBoardApp
//
//  Created by Kabir Cahill on 2017-11-16.
//  Copyright © 2017 Kabir Cahill. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    var isRecording: Bool = false
    var seconds = 0
    var timer = Timer()
    var audioSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var settings = [String : Int]()
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var timeDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
            audioSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Allow")
                    } else {
                        print("Dont Allow")
                    }
                }
            }
        } catch {
            print("failed to record!")
        }
        
        // Audio Settings
        
        settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        recordButton.layer.cornerRadius = 8
        recordButtonShowAsStart()
        //timeDisplay.text = ":00"
        isRecording = false
        
        playButton.layer.cornerRadius = 8
        playButton.backgroundColor = UIColor.green
        playButton.setTitleColor(UIColor.white, for: .normal)
        playButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func record(_ sender: Any) {
        if(!isRecording) {
            isRecording = true
            startRecording()
            recordButtonShowAsStop()
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimeDisplay), userInfo: nil, repeats: true)
            timeDisplay.text = ":00"
            seconds = 0
            playButton.isHidden = true
            
        } else {
            isRecording = false
            finishRecording()
            recordButtonShowAsStart()
            timer.invalidate()
            recordButton.setTitle("Record Again", for: .normal)
            playButton.isHidden = false
        }
    }
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            audioRecorder = try AVAudioRecorder(url: self.directoryURL()! as URL,
                                                settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            finishRecording()
        }
        do {
            try audioSession.setActive(true)
            audioRecorder.record()
        } catch {
        }
    }
    
    func directoryURL() -> NSURL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.appendingPathComponent("sound.m4a")
        print(soundURL)
        return soundURL as NSURL?
    }
    
    func finishRecording() {
        audioRecorder.stop()
    }
    
    @objc func updateTimeDisplay() {
        seconds += 1;
        
        timeDisplay.text = (seconds < 10 ? ":0\(seconds)" : ":\(seconds)")
    }
    
    func recordButtonShowAsStart() {
        recordButton.layer.borderColor = UIColor.blue.cgColor
        recordButton.layer.borderWidth = 1
        recordButton.backgroundColor = UIColor.white
        recordButton.setTitleColor(UIColor.blue, for: .normal)
        recordButton.setTitle("Start Recording", for: .normal)
    }
    
    func recordButtonShowAsStop() {
        recordButton.layer.borderWidth = 0
        recordButton.backgroundColor = UIColor.red
        recordButton.setTitleColor(UIColor.white, for: .normal)
        recordButton.setTitle("Stop Recording", for: .normal)
    }
    
    @IBAction func playRecording(_ sender: Any) {
        if !audioRecorder.isRecording {
            self.audioPlayer = try! AVAudioPlayer(contentsOf: audioRecorder.url)
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.delegate = self
            self.audioPlayer.play()
        }
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
