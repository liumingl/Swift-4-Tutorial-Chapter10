//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
  var finalURL = ""
  
  //Pre-setup IBOutlets
  @IBOutlet weak var bitcoinPriceLabel: UILabel!
  @IBOutlet weak var currencyPicker: UIPickerView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    currencyPicker.delegate = self
    currencyPicker.dataSource = self
  }
  
  
  //TODO: Place your 3 UIPickerView delegate methods here
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return currencyArray.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return currencyArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    finalURL = baseURL + currencyArray[row]
    getBitcoinData(url: finalURL)
  }
  
  
  //MARK: - Networking
  /***************************************************************/
  
  func getBitcoinData(url: String) {
    
    Alamofire.request(url, method: .get)
      .responseJSON { response in
        if response.result.isSuccess {
          
          print("成功! 已经获取到比特币数据")
          let bitcoinJSON : JSON = JSON(response.result.value!)
          
          self.updateBitcoinData(json: bitcoinJSON)
          
        } else {
          print("Error: \(String(describing: response.result.error))")
          self.bitcoinPriceLabel.text = "连接问题"
        }
    }
  }
  
  
  
  
  
  //MARK: - JSON Parsing
  /***************************************************************/
  
  func updateBitcoinData(json: JSON) {
    if let bitcoinResult = json["last"].rawString() {
      bitcoinPriceLabel.text = bitcoinResult
    }
  }
  
  
  
  
  
}

