//
//  mainView.swift
//  Pods
//
//  Created by Burak Gunerhanal on 02/04/2017.
//
//

import UIKit

class mainView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.00, green:0.58, blue:0.50, alpha:1.0)
        
        //logo has been created in here
        let logo = UILabel()
        logo.text = "Sudoku"
        logo.numberOfLines = 0
        logo.frame = CGRect(x:self.view.frame.size.width/2, y:self.view.frame.size.height/7 , width:200 , height:130)
        // self.view.bounds.size.width/2,50,self.view.bounds.size.width, self.view.bounds.size.height
        logo.center.x = self.view.center.x
        logo.textAlignment = .center
        logo.backgroundColor = UIColor(red:1.00, green:0.72, blue:0.00, alpha:1.0)
        logo.textColor = UIColor.white
        //title.font = [UIFont fontWithName:@"Quicksand-Bold" size:24.0];
        logo.font = UIFont(name: "Thonburi-bold", size: 35)
        logo.layer.masksToBounds = true
        logo.layer.cornerRadius = 15
        
        //play button has been created in here
        let playBtn = UIButton()
        playBtn.setTitle( "   ▶️ Play", for:.normal)
        playBtn.frame = CGRect(x:self.view.frame.size.width/2, y:self.view.frame.size.height/2 , width:200 , height:50)
        playBtn.center.x = self.view.center.x
        playBtn.backgroundColor = UIColor(red:1.00, green:0.72, blue:0.00, alpha:1.0)
        playBtn.titleLabel!.textAlignment = .left
        playBtn.titleLabel!.font =  UIFont(name: "Thonburi", size: 20)
        //playBtn.textColor = UIColor.white
        //playBtn.font = UIFont(name: "Thonburi-bold", size: 20)!
        playBtn.layer.masksToBounds = true
        playBtn.layer.cornerRadius = 15
        
        //multiplayer button has been created in here
        let multiplayerBtn = UILabel()
        multiplayerBtn.text = "   👥 Multiplayer"
        multiplayerBtn.frame = CGRect(x:self.view.frame.size.width/2, y:400 , width:200 , height:50)
        // self.view.bounds.size.width/2,50,self.view.bounds.size.width, self.view.bounds.size.height
        multiplayerBtn.center.x = self.view.center.x
        multiplayerBtn.textAlignment = .left
        multiplayerBtn.backgroundColor = UIColor(red:1.00, green:0.72, blue:0.00, alpha:1.0)
        multiplayerBtn.textColor = UIColor.white
        //title.font = [UIFont fontWithName:@"Quicksand-Bold" size:24.0];
        multiplayerBtn.font = UIFont(name: "Thonburi", size: 20)
        multiplayerBtn.layer.masksToBounds = true
        multiplayerBtn.layer.cornerRadius = 15
        
        //solve button has been created in here
        let solveBtn = UILabel()
        solveBtn.text = "   🔍 Solve"
        solveBtn.frame = CGRect(x:self.view.frame.size.width/2, y:470 , width:200 , height:50)
        // self.view.bounds.size.width/2,50,self.view.bounds.size.width, self.view.bounds.size.height
        solveBtn.center.x = self.view.center.x
        solveBtn.textAlignment = .left
        solveBtn.backgroundColor = UIColor(red:1.00, green:0.72, blue:0.00, alpha:1.0)
        solveBtn.textColor = UIColor.white
        //title.font = [UIFont fontWithName:@"Quicksand-Bold" size:24.0];
        solveBtn.font = UIFont(name: "Thonburi", size: 20)
        solveBtn.layer.masksToBounds = true
        solveBtn.layer.cornerRadius = 15
        
        view.addSubview(logo)
        view.addSubview(playBtn)
        view.addSubview(multiplayerBtn)
        view.addSubview(solveBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
