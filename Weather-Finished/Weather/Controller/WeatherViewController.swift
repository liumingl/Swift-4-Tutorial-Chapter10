//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  
  //Constants
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let APP_ID = "1d505359c7db3fcf2502ffd40525ddc8"
  
  //TODO: Declare instance variables here
  let locationManager = CLLocationManager()
  let weatherDataModel = WeatherDataModel()
  
  //Pre-linked IBOutlets
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //TODO:Set up the location manager here.
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  
  
  //MARK: - Networking
  /***************************************************************/
  
  //Write the getWeatherData method here:
  func getWeatherData(url: String, parameters: [String: String]) {
    Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
      response in
      if response.result.isSuccess {
        print("成功获取气象数据")
        let weatherJSON: JSON = JSON(response.result.value!)
        self.updateWeatherData(json: weatherJSON)
      }else {
        print("错误 \(String(describing: response.result.error))")
        self.cityLabel.text = "连接问题"
      }
    }
  }
  
  
  //MARK: - JSON Parsing
  /***************************************************************/
  
  
  //Write the updateWeatherData method here:
  func updateWeatherData(json: JSON) {
    if let tempResult = json["main"]["temp"].double {
      weatherDataModel.temperature = Int(tempResult - 273.15)
      weatherDataModel.city = json["name"].stringValue
      weatherDataModel.condition = json["weather"]["id"].intValue
      weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
      
      updateUIWithWeatherData()
    }else {
      cityLabel.text = "气象信息不可用"
    }
  }
  
  
  
  
  //MARK: - UI Updates
  /***************************************************************/
  
  
  //Write the updateUIWithWeatherData method here:
  func updateUIWithWeatherData() {
    cityLabel.text = weatherDataModel.city
    temperatureLabel.text = String(weatherDataModel.temperature) + "°"
    weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
  }
  
  
  //MARK: - Location Manager Delegate Methods
  /***************************************************************/
  
  //Write the didUpdateLocations method here:
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      locationManager.delegate = nil
      
      print("经度 = \(location.coordinate.longitude)，纬度 = \(location.coordinate.latitude)")
      
      let latitude = String(location.coordinate.latitude)
      let longitude = String(location.coordinate.longitude)
      
      let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
      getWeatherData(url: WEATHER_URL, parameters: params)
    }
  }
  
  //Write the didFailWithError method here:
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    cityLabel.text = "定位失败"
  }
  
  
  
  
  //MARK: - Change City Delegate methods
  /***************************************************************/
  
  
  //Write the userEnteredANewCityName Delegate method here:
  func userEnteredANewCityName(city: String) {
    let params: [String: String] = ["q": city, "appid": APP_ID]
    getWeatherData(url: WEATHER_URL, parameters: params)
  }
  
  
  //Write the PrepareForSegue Method here
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "changeCityName" {
      let destinationVC = segue.destination as! ChangeCityViewController
      destinationVC.delegate = self
    }
  }
  
  
  
  
}


