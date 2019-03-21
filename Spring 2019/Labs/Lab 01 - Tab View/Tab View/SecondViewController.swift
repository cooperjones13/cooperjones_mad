//
//  SecondViewController.swift
//  Tab View
//
//  Created by Cooper Jones on 2/4/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate{

    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var play: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        play.isEnabled = false
        stop.isEnabled = false
        
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        print(docDir)
        let audioFileURL = docDir.appendingPathComponent(fileName)
        print(audioFileURL)
        
        let audioSession = AVAudioSession.sharedInstance() //the shared audio session instance
        do {
            //sets he category for recording and playback of audio
            if #available(iOS 10.0, *) {
                try! audioSession.setCategory(.playback, mode: .default)
            }
            else {
                // Workaround until https://forums.swift.org/t/using-methods-marked-unavailable-in-swift-4-2/14949 isn't fixed
                AVAudioSession.sharedInstance().perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.Category.playback)
            }

        } catch let error as NSError{
            print("audio session error: \(error.localizedDescription)")
        }
        
        //recorder settings
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), //specifies audio codec
            AVSampleRateKey: 12000, //sample rate in hertz
            AVNumberOfChannelsKey: 1, //number of channels
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue //audio bit rate
        ]
        
        do {
            //create the AVAudioRecorder instance
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder?.prepareToRecord()
            print("audio recorder ready")
        } catch {
            print("audio recorder error: \(error.localizedDescription)")
        }
        
    }

    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    let fileName = "recordedAudio.m4a"
    
    @IBAction func recordAudio(_ sender: UIButton) {
        if audioRecorder?.isRecording == false{
            play.isEnabled = false
            stop.isEnabled = true
            audioRecorder?.delegate = self
            print("Begin Recording")
            audioRecorder?.record()
        }
        
    }
    
    
    @IBAction func stopRecording(_ sender: UIButton) {
        stop.isEnabled = false
        play.isEnabled = true
        record.isEnabled = true
        
        if audioRecorder?.isRecording == true{
            print("stop recording")
            audioRecorder?.stop()
        } else {
            print("stop playing")
            audioPlayer?.stop()
        }
    }
    

    @IBAction func playRecording(_ sender: UIButton) {
        if audioRecorder?.isRecording == false{
            stop.isEnabled = true
            record.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay() //prepares the audio player for playback by preloading its buffers
                print("start playing")
                audioPlayer!.play() //plays audio file
            } catch let error {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        record.isEnabled = true
        stop.isEnabled = false
    }
}

