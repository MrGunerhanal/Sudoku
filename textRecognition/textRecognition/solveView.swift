//
//  Created by Burak Gunerhanal on 02/04/2017.
//

import UIKit
import TesseractOCR

class solveView: UIViewController, G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var photoImageView = UIImageView(frame: CGRect(x:85, y:120, width:200, height:200))
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var showResult: UILabel!
    @IBOutlet weak var digitHolder: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        self.view.addSubview(photoImageView)
        
    }

    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress)%")
    }
    @IBAction func cameraAction(_ sender: UIButton) {
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    @IBAction func choiceImage(_ sender: UIButton) {
        
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        present(photoPicker, animated: true, completion: nil)
    }
    
    func scaleImage(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor:CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let scaledImage = scaleImage(selectedImage!, maxDimension: 640)
        self.dismiss(animated: false, completion:  {self.startScan(scaledImage)
        })
    }
    
    @IBAction func startScan(_ image: UIImage) {
        
        if let tesseract = G8Tesseract(language: "eng")
        {
            tesseract.delegate = self
            tesseract.image = image.g8_blackAndWhite()
            tesseract.recognize()
            
            digitHolder.text = tesseract.recognizedText
        }
    }
    @IBAction func checkSudoku(_ sender: UIButton) {
        
        let output = digitHolder.text
        let spaceRemoved = output?.replacingOccurrences(of: " ", with: "")
        
        var matrix : [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        var lineCount = 0
        var count = 0
        for c in (spaceRemoved?.characters)! {
            let dig = isDigit(digit: String(c))
            if(dig != 0){
                matrix[lineCount][count % 9] = dig
                count += 1
                if(count % 9 == 0) {
                    lineCount += 1
                }
            }
        }
        
        var result: Bool
        result = rowCheck(matrix: matrix)
        result = columnCheck(matrix: matrix)
    }
    
    func rowCheck(matrix: Array<Array<Int>>) -> Bool
    {
        for row in matrix{
            for i in 1...9{
                if !row.contains(i) {
                    showResult.text = "Incorrectly Solved"
                    showResult.textColor = UIColor.red
                    return false
                }
            }
        }
        showResult.text = "Correctly Solved"
        showResult.textColor = UIColor.green
        return true
    }
    
    func columnCheck(matrix: Array<Array<Int>>) -> Bool{
        for j in 0...8{
            var column = [Int]()
            for i in 0...8{
                column.append(matrix[i][j])
            }
            for i in 1...9{
                if !column.contains(i) {
                    showResult.text = "Incorrectly Solved"
                    showResult.textColor = UIColor.red
                    return false
                }
            }
        }
        showResult.text = "Correctly Solved"
        showResult.textColor = UIColor.green
        return true
    }
    
    func isDigit(digit: String) -> Int{
        for i in 1...9{ 
            if( Int(digit) == i) {
                return i
            }
        }
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
