//
//  ViewController.swift
//  DemoTextFieldValidation
//
//  Created by Jony Singla on 17/03/17.
//  Copyright © 2017 Jony Singla. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // open numeric keybad on this text field
        self.txtMobileNo.keyboardType = UIKeyboardType.numberPad
        
    }
  
    // MARK: text field delegate
    
    //    1 (555) 555 5555
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == self.txtMobileNo) {
            let  char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            
            var totalString = ""
            if  textField.text?.characters.count == 0
            {
                totalString = "\(string)"
            }
            else
            {
                totalString = String(format:"%@%@",textField.text!,string)
            }
            if totalString.characters.count == 1 && isBackSpace != -92
            {
                textField.text = String(format:"%@ (",totalString)
                return false
            }
            else if totalString.characters.count == 6 && isBackSpace != -92
            {
                textField.text = String(format:"%@) ",totalString)
                return false
            }
            else if totalString.characters.count == 11 && isBackSpace != -92
            {
                textField.text = String(format:"%@ ",totalString)
                return false
            }
            else if totalString.characters.count == 17
            {
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: Email Validation format
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }

    // MARK: Button tap action
    
    @IBAction func nextScreen(_ sender: Any) {
        
//        let isValidEmail = UtilityClass.isValidEmail(testStr: self.txtEmail.text!)
        
        if (txtMobileNo.text?.isEmpty)! {
            
            UtilityClass.showAlert(title: "", with: "Please enter a mobile number", style: .alert, onView: self)
        }
        else if (txtEmail.text?.isEmpty)! {
            
            UtilityClass.showAlert(title: "", with: "Please enter a email address.", style: .alert, onView: self)
        }
        else if validateEmail(candidate: txtEmail.text!) {
            
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC")as! SecondViewController
            navigationController?.pushViewController(secondVC, animated: true)
        }
        else {
            UtilityClass.showAlert(title: "", with: "Please enter a valid email address.", style: .alert, onView: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

