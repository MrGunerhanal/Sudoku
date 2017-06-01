//
//  settingsViewController.swift
//  textRecognition
//
//  Created by Burak Gunerhanal on 09/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

import UIKit
import AVFoundation

class settingsViewController: UIViewController {
    
    @IBOutlet weak var darkSwitch: UISwitch!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var lightSwitch: UISwitch!
    
    var DarkOn = Bool()
    var LightOn = Bool()
    var musicPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!))
            musicPlayer.play()
        } catch
        {
            print(error)
        }
        
        let DarkDefault = UserDefaults.standard
        DarkOn = DarkDefault.bool(forKey: "DarkDefault")
        

        
        let LightDefault = UserDefaults.standard
        LightOn = LightDefault.bool(forKey: "LightDefault")
        
        
        
        if(DarkOn==true){
            darkSwitch.isOn=true
            lightSwitch.isOn=false
            darkTheme()
        }
        if(LightOn==true){
            darkSwitch.isOn=false
            lightSwitch.isOn=true
            lightTheme()
        }
    }
    
    func darkTheme()
    {
         view.backgroundColor = UIColor.black
    }
    func lightTheme()
    {
        view.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchBtn(_ sender: UIButton) {
        if(switchBtn.titleLabel!.text == "▶︎")
        {
            switchBtn.setTitle("◼︎", for: UIControlState.normal)
            musicPlayer.play()
        }
        if(switchBtn.titleLabel!.text == "◼︎")
        {
            switchBtn.setTitle("▶︎", for: UIControlState.normal)
            musicPlayer.stop()
            musicPlayer.currentTime = 0
        }
        
    }
    
    @IBAction func lightAction(_ sender: Any) {
        darkSwitch.isOn = false
        lightSwitch.isOn = true
        
        lightTheme()
        
        
        let DarkDefault = UserDefaults.standard
        DarkDefault.set(NSKeyedArchiver.archivedData(withRootObject: UIColor.black), forKey: "DarkDefault")
        
        let LightDefault = UserDefaults.standard
        LightDefault.set(NSKeyedArchiver.archivedData(withRootObject: UIColor.white), forKey: "LightDefault")
    }
    
    @IBAction func darkAction(_ sender: Any) {
        darkSwitch.isOn = true
        lightSwitch.isOn = false
        
        darkTheme()
       
        
        let DarkDefault = UserDefaults.standard
        DarkDefault.set(NSKeyedArchiver.archivedData(withRootObject: UIColor.black), forKey: "DarkDefault")
        
        let LightDefault = UserDefaults.standard
        LightDefault.set(NSKeyedArchiver.archivedData(withRootObject: UIColor.white), forKey: "LightDefault")
    }
}

