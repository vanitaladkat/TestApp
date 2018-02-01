//
//  TestViewController.swift
//  TestApp
//
//  Created by Vanita on 12/6/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var i = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.inputView = UIView()
        textField.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addNumberBtnACtion(_ sender: Any) {
//        textField.text =  (textField.text ?? "") + "\(i)"

//        let range: NSRange = NSRange.init(location: 0, length: 1)
//        if self.textField(textField, shouldChangeCharactersIn: range, replacementString: String((sender as AnyObject).tag)) {
//            textField.text = textField.text! + String ((sender as! UIButton).tag)
//        }
        
//        if self.textField(textField, shouldChangeCharactersIn: Range(0, in: (textField.text?.count)! - 1), replacementString: "\(i)") {
//            textField.insertText("\(i)")
//        }
        i+=1
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

extension TestViewController: UITextFieldDelegate {
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        guard string.count > 0 else {
//            return true
//        }
//
//        print("string")
//
//        return true
//    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change", string)
        return true
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin editing")
    }
}

extension TestViewController {
    func myFunc() {
        
    }
}

class TextChildViewController: TestViewController {
    
}

class MyTime {
    var seconds:Double = 0
    
    init(seconds: Double) {
        self.seconds = seconds
    }
    
    var minutes: Double {
        get {
            return (seconds / 60)
        }
        set {
            self.seconds = (newValue * 60)
        }
    }
    
    var hours: Double {
        get {
            return (seconds / (60 * 60))
        }
        set {
            self.seconds = (newValue * (60 * 60))
        }
    }
    
    var days:  Double {
        get {
            return (seconds / (60 * 60 * 24))
        }
        set {
            self.seconds = (newValue * (60 * 60 * 24))
        }
    }
}
