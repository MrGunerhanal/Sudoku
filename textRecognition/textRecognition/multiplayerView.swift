//
//  multiplayerView.swift
//  textRecognition
//
//  Created by Burak Gunerhanal on 03/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class multiplayerView: UIViewController, MCBrowserViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var showTimer: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    
    var timeInterval = TimeInterval()
    var timer = Timer()
    
    var currentPlayer : String!
    var appDelagate : AppDelegate!
    
    let gridview = UIView()
    var showSolution: Bool = false
    var difficulty : puzzleDifficulty?
    var generator : SudokuGenerator?
    var puzzle : Puzzle?
    let SHOW_NUMBERS :Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelagate = UIApplication.shared.delegate as! AppDelegate!
        appDelagate.multiplayer.setupPeerWithDisplay(UIDevice.current.name)
        appDelagate.multiplayer.setSession()
        appDelagate.multiplayer.selfAdvertise(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(multiplayerView.peerChangedStateWithNotification(_:)), name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
        checkBtn.isHidden = true
    }
    
    func start() {
        if !timer.isValid {
            let theSelector : Selector = #selector(sudokuView.updateTime)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: theSelector, userInfo: nil, repeats: true)
            timeInterval = Date.timeIntervalSinceReferenceDate
        }
    }
    
    func updateTime() {
        let timeNow = Date.timeIntervalSinceReferenceDate
        var editedTime: TimeInterval = timeNow - timeInterval
        let minutes = UInt8(editedTime / 60.0)
        editedTime -= (TimeInterval(minutes) * 60)
        let seconds = UInt8(editedTime)
        editedTime -= TimeInterval(seconds)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        showTimer.text = "\(strMinutes):\(strSeconds)"
    }
    
    func callSudokuPuzzle()
    {
        checkBtn.isHidden = false
        difficulty = diff
        generator = SudokuGenerator()
        
        drawGrid()
        generatePuzzle()
        start()
    }
    
    func drawGrid() {
        
        var rect = self.view.frame
        
        rect.size.width -= 20;
        rect.size.width = rect.size.height / 2 < rect.size.width ? rect.size.height / 2 : rect.size.width;
        rect.size.width += 2;
        rect.size.height = rect.size.width;
        rect.origin.x += (self.view.frame.size.width - rect.size.width) / 2;
        rect.origin.y += 70;
        
        gridview.frame = rect;
        gridview.backgroundColor = UIColor(red:0.9, green:0.9, blue:0.9, alpha:1.0)
        gridview.layer.borderColor = UIColor.black.cgColor;
        gridview.layer.borderWidth = 2;
        
        self.view.addSubview(gridview)
    }
    func generatePuzzle() {
        generatePuzzleAndSolution(solution: nil)
    }
    
    func generatePuzzleAndSolution(solution: Solution?)
    {
        var puzzle: Puzzle? = nil
        
        if (solution == nil)
        {
            puzzle = generator?.generate(difficulty!)
        }
        else
        {
            puzzle = generator?.generatePuzzle(with: solution!, difficulty: difficulty!)
        }
        
        puzzle?.solution.printGrid()
        puzzle?.grid.printGrid()
        
        self.puzzle = puzzle
        
        for view: UIView in gridview.subviews
        {
            view.removeFromSuperview()
        }
        
        self.layoutGrid(solutionToShow: showSolution ? self.puzzle?.solution : self.puzzle?.grid!)
        
    }
    
    
    func layoutGrid(solutionToShow: Solution?){
        
        let gridview: UIView? = self.gridview
        var rect: CGRect = gridview!.frame
        
        let sizeOfCells: CGFloat = (rect.size.width - 2) / 9
        for i in 0...8{
            for j in 0...8{
                var textField = UITextField()
                textField.delegate = self;
                if(!SHOW_NUMBERS){
                    textField = self.generateTextField(pos: Position())
                }else{
                    let pos: Position = (solutionToShow!.getAtX(UInt(j), y: UInt(i)))!
                    textField = self.generateTextField(pos: pos)
                    
                }
                
                textField.tag = i * 9 + j
                textField.textAlignment = .center
                rect = CGRect(x:CGFloat(j) * sizeOfCells, y:CGFloat(i) * sizeOfCells, width: sizeOfCells + 2, height:sizeOfCells + 2)
                textField.layer.borderColor = UIColor.lightGray.cgColor
                textField.layer.borderWidth = 2
                textField.frame = rect
                
                gridview?.addSubview(textField)
            }
        }
        drawLines(rect, sizeOfSquares: Int(sizeOfCells))
    }
    
    func generateTextField(pos: Position)-> UITextField
    {
        pos.temporary = true
        let textField = UITextField()
        //Not editable!
        if (pos.value.intValue != 0)
        {
            textField.text = pos.value.stringValue
            
            textField.isUserInteractionEnabled = false;
            textField.backgroundColor = UIColor.white;
        }
        #if TEXT_COLOR
            textField.textColor = UIColor.darkGray.cgColor
        #else
            textField.textColor = UIColor.black
            textField.font =  UIFont(name: "Quicksand-Bold.tff", size: 20)
        #endif
        textField.keyboardType = UIKeyboardType.numberPad
        textField.clearsOnBeginEditing = true
        textField.delegate = self
        return textField
    }
    
    func drawLines(_ rect: CGRect, sizeOfSquares: Int) {
        var line: UIView? = UILabel()
        var rect = CGRect(x: CGFloat(0), y: CGFloat(sizeOfSquares * 3), width: CGFloat(sizeOfSquares * 9 + 2), height: CGFloat(2))
        
        line?.frame = rect
        line?.layer.backgroundColor = UIColor.black.cgColor
        gridview.addSubview(line!)
        
        line = UILabel()
        rect = CGRect(x: CGFloat(0), y: CGFloat(sizeOfSquares * 6), width: CGFloat(sizeOfSquares * 9 + 2), height: CGFloat(2))
        line?.frame = rect
        line?.layer.backgroundColor = UIColor.black.cgColor
        gridview.addSubview(line!)
        
        line = UILabel()
        rect = CGRect(x: CGFloat(sizeOfSquares * 3), y: CGFloat(0), width: CGFloat(2), height: CGFloat(sizeOfSquares * 9 + 2))
        line?.frame = rect
        line?.layer.backgroundColor = UIColor.black.cgColor
        gridview.addSubview(line!)
        
        line = UILabel()
        rect = CGRect(x: CGFloat(sizeOfSquares * 6), y: CGFloat(0), width: CGFloat(2), height: CGFloat(sizeOfSquares * 9 + 2))
        line?.frame = rect
        line?.layer.backgroundColor = UIColor.black.cgColor
        gridview.addSubview(line!)
    }
    
    func textFieldDidEndEditing(_ field: UITextField)
    {
        //update the user grid
        var index = NSInteger()
        index = field.tag
        
        puzzle?.grid.position(at: UInt(index)).value = (CInt(field.text!) as NSNumber!)
        
        #if TEXT_COLOR
            field.textColor = UIColor.darkGray
        #else
            field.textColor = UIColor.black
        #endif
    }
    
    @IBAction func askQuit(_ sender: UIButton) {
        
        let refreshAlert = UIAlertController(title: "Back to Main Menu", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
            { (action: UIAlertAction!) in
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainMenu") as! ViewController
                self.present(newViewController, animated: true, completion: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:
            { (action: UIAlertAction!) in
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func checkSudoku(_ sender: AnyObject) {
        for view: UIView in gridview.subviews {
            if (view is UITextField && view.isUserInteractionEnabled) {
                let textField: UITextField? = (view as? UITextField)
                if(textField?.text! != ""){
                    let tag = Int(view.tag)
                    
                    textField?.textColor = UIColor.green;
                    
                    let correct : Bool? = puzzle?.correctAnswer(atPosition: Int32(tag));
                    
                    let color : UIColor = correct! ? UIColor.black : UIColor.red;
                    
                    textField?.textColor = color
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connection(_ sender: Any) {
        
        if appDelagate.multiplayer.session != nil{
            appDelagate.multiplayer.setBrowser()
            appDelagate.multiplayer.browser.delegate = self
            
            self.present(appDelagate.multiplayer.browser, animated:true, completion: nil)
        }
    }
    
    func peerChangedStateWithNotification(_ notification:Notification){
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        
        let state = userInfo.object(forKey: "state") as! Int
        
        if state != MCSessionState.connecting.rawValue{
            self.navigationItem.title = "Connected"
            callSudokuPuzzle()
        }
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        appDelagate.multiplayer.browser.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        appDelagate.multiplayer.browser.dismiss(animated: true, completion: nil)
    }
    
}
