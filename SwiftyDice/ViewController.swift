//
//  ViewController.swift
//  SwiftyDice
//
//  Created by Nathan Mckenzie on 10/13/20.
//  Copyright © 2020 Nathan Mckenzie. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var diceImageView: UIImageView!
    @IBOutlet var criticalLabel: UILabel!
    
    var rollAudioPlayer: AVAudioPlayer?
    var winAudioPlayer : AVAudioPlayer!
    var loseAudioPlayer: AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rollUrl = Bundle.main.path(forResource: "rolldice", ofType: "mp3")
        let winUrl = Bundle.main.path(forResource: "zfanfare", ofType: "mp3")
        let loseUrl = Bundle.main.path(forResource: "failwah", ofType: "mp3")


        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let rollUrl = rollUrl else{
                return
            }
            guard let winUrl = winUrl else{
                return
            }
            guard let loseUrl = loseUrl else{
                return
            }
            
            rollAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: rollUrl))
            winAudioPlayer = try AVAudioPlayer( contentsOf: URL(fileURLWithPath: winUrl))
            loseAudioPlayer = try AVAudioPlayer( contentsOf: URL(fileURLWithPath: loseUrl))


        }
        catch{
            print(error)
        }
    }
    @IBAction func buttonGotPressed(){
        rollAudioPlayer?.play()
        rollDice()
    }
    
    func rollDice(){
        //do cool stuff here
        print("WE ROLLIN' DICE!")
        
        let rolledNumber = Int.random(in: 1...20)
        
        let imageName = "d\(rolledNumber)"
        
        diceImageView.image = UIImage(named: imageName)
        
        if(imageName == "d1")
        {
            loseAudioPlayer!.play()
            criticalLabel.text = "CRITICAL MISS"
        }else if(imageName == "d20"){
            winAudioPlayer!.play()
            criticalLabel.text = "CRITICAL HIT"
            
        }else{
            rollAudioPlayer!.play()
            criticalLabel.text = ""
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollDice()
    }
    

}

