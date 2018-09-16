//
//  ViewController.swift
//  Segues
//
//  Created by 刘铭 on 2018/2/11.
//  Copyright © 2018年 刘铭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func buttonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "goToSecondScreen", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToSecondScreen" {
      let destinationVC = segue.destination as! SecondViewController
      destinationVC.textPassedOver = textField.text!
    }
  }
  
}

