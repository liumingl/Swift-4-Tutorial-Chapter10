//
//  SecondViewController.swift
//  PassDataBetweenVC
//
//  Created by 刘铭 on 2018/2/12.
//  Copyright © 2018年 刘铭. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  
  var data = ""
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var textField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    label.text = data
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func sendDataBack(_ sender: UIButton) {
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
