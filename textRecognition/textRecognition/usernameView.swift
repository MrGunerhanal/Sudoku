//
//  usernameView.swift
//  textRecognition
//
//  Created by Burak Gunerhanal on 04/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

import UIKit

class usernameView: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var getUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let name: String? = UserDefaults.standard.object(forKey: "name") as? String
        if let nameToDisplay = name{
            username.text = nameToDisplay
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveUsername(_ sender: Any) {
        
        username.text = getUsername.text
        UserDefaults.standard.set(username.text, forKey: "name")
    }

}
