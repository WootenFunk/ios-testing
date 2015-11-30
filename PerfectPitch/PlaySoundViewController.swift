//
//  PlaySoundViewController.swift
//  PerfectPitch
//
//  Created by Alfredo Regis on 19/11/15.
//  Copyright © 2015 Alfredo Regis. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    //var fileName = "movie_quote.mp3"
    var bgMusic:AVAudioPlayer = AVAudioPlayer()
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var vArchivo:NSURL!

    var audioEngine:AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            //let fileUrl = NSURL(fileURLWithPath: filePath)
            //audioPlayer = try! AVAudioPlayer(contentsOfURL: fileUrl, fileTypeHint: nil)
            //audioPlayer = try! AVAudioPlayer(contentsOfURL: vArchivo, fileTypeHint: nil)
              audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint: nil)
            audioPlayer.enableRate = true
        
            audioEngine = AVAudioEngine()
            audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        //}else{
        //    print("Error in the file path")
        //}
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonSnail(sender: UIButton) {
        AudioProperties(0.5)
        /*
        let bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("movie_quote", withExtension: "mp3")!
        do { bgMusic = try AVAudioPlayer(contentsOfURL: bgMusicURL, fileTypeHint: nil) } catch _ { return print("file not found") }
        bgMusic.numberOfLoops = 0
        bgMusic.prepareToPlay()
        bgMusic.play()
        */
    }
    
    @IBAction func ButtonRabbit(sender: UIButton) {
        AudioProperties(2.0)
    }

    @IBAction func ButtonStop(sender: UIButton) {
        audioPlayer.stop()
    }
    
    func AudioProperties(vRate: Float){
        audioPlayer.stop()
        audioPlayer.rate = vRate
        audioPlayer.currentTime = 0.0   //inicializa el audio
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
