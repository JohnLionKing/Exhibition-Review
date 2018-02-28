//
//  ViewController.swift
//  Review
//
//  Created by Star on 11/17/17.
//  Copyright © 2017 Star. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layoutStack: UIStackView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var msgText: UITextView!
    @IBOutlet weak var thankyouLabel: UILabel!
    @IBOutlet weak var thankyouImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(gesture:)))

        // add it to the image view;
        thankyouImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            self.layoutStack.isHidden = false
            self.thankyouImage.isHidden = true
            nameText.text = ""
            emailText.text = ""
            msgText.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSubmitButton(_ sender: UIButton) {
        
        //let parameters = ["name": nameText.text, "email": emailText.text, "msg": msgText.text] as Dictionary<String, String?>
        var bodyData = "name=" + nameText.text! + "&email=" + emailText.text!
            bodyData += "&msg=" + msgText.text!;
        
        let myUrl = URL(string: "http://192.168.1.195/review/saveHistory.php");

        var request = URLRequest(url:myUrl!)

        request.httpMethod = "POST"// Compose a query string

        do {
            //request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                //self.thankyouLabel.text = error;
                //print("error=\(error)")
                return
            }
         
            //You can print out response object
            //print("response = \(response)")
            
        }
        task.resume()
        self.layoutStack.isHidden = true
        self.thankyouImage.isHidden = false
    }
    
    
}

