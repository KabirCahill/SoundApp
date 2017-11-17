//
//  RecordViewController.swift
//  SoundBoardApp
//
//  Created by Kabir Cahill on 2017-11-16.
//  Copyright © 2017 Kabir Cahill. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    var isRecording: Bool = false
    var seconds = 0
    var timer = Timer()
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var timeDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recordButton.layer.cornerRadius = 8
        recordStart()
        timeDisplay.text = "0:00"
        isRecording = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func record(_ sender: Any) {
        if(!isRecording) {
            isRecording = true
            recordStop()
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimeDisplay), userInfo: nil, repeats: true)

        } else {
            isRecording = false
            recordStart()
            timer.invalidate()
        }
    }
    
    @objc func updateTimeDisplay() {
        seconds += 1;
        
        timeDisplay.text = (seconds < 10 ? "0:0\(seconds)" : "0:\(seconds)")
    }
    
    func recordStart() {
        recordButton.layer.borderColor = UIColor.blue.cgColor
        recordButton.layer.borderWidth = 1
        recordButton.backgroundColor = UIColor.white
        recordButton.setTitleColor(UIColor.blue, for: .normal)
        recordButton.setTitle("Start Recording", for: .normal)
    }
    
    func recordStop() {
        recordButton.layer.borderWidth = 0
        recordButton.backgroundColor = UIColor.red
        recordButton.setTitleColor(UIColor.white, for: .normal)
        recordButton.setTitle("Stop Recording", for: .normal)
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
