//
//  ViewController.swift
//  PassDataBetweenVC
//
//  Created by 刘铭 on 2018/2/12.
//  Copyright © 2018年 刘铭. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var textField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func sendButtonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "sendDataForwards", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "sendDataForwards" {
      let secondVC = segue.destination as! SecondViewController
      secondVC.data = textField.text!
    }
  }
  
}

