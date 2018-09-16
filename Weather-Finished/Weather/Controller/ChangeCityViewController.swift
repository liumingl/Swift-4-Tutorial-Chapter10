//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit


//Write the protocol declaration here:
protocol ChangeCityDelegate {
  func userEnteredANewCityName(city: String)
}

class ChangeCityViewController: UIViewController {
  
  //Declare the delegate variable here:
  var delegate: ChangeCityDelegate?
  
  //This is the pre-linked IBOutlets to the text field:
  @IBOutlet weak var changeCityTextField: UITextField!
  
  
  //This is the IBAction that gets called when the user taps on the "Get Weather" button:
  @IBAction func getWeatherPressed(_ sender: AnyObject) {
    
    //1 通过Text Field得到城市名称
    let cityName = changeCityTextField.text!
    
    //2 如果有一个delegate设置，则调用userEnteredANewCityName()方法
    delegate?.userEnteredANewCityName(city: cityName)
    
    //3 销毁CityViewController并返回到WeatherViewController
    self.dismiss(animated: true, completion: nil)
    
  }
  
  
  
  //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
  @IBAction func backButtonPressed(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
