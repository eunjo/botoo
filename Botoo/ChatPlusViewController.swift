//
//  ChatPlusViewController.swift
//  Botoo
//
//  Created by 혜인 on 2016. 7. 4..
//  Copyright © 2016년 dolphins. All rights reserved.
//

import UIKit
import MobileCoreServices
import ContactsUI
import AVFoundation

class ChatPlusViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CNContactPickerDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    
    @IBAction func contactsButtonTapped(sender: AnyObject) {
        
        let peoplePicker = CNContactPickerViewController()
        
        peoplePicker.delegate = self
        self.presentViewController(peoplePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func sendLocationButtonTapped(sender: AnyObject) {
        
        
    }

    @IBAction func sendRecButtonTapped(sender: AnyObject) {
//        self.loadRecordingUI()
        
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().stringByAppendingString("recording.m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
//            recordButton.setTitle("Tap to Re-record", forState: .Normal)
            print("successsssssss!!")
        } else {
//            recordButton.setTitle("Tap to Record", forState: .Normal)
            // recording failed :(
        }
    }
    
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
