//
//  CityWeatherDetailsViewController.swift
//  TestApp
//
//  Created by Vanita on 11/9/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import UIKit

class CityWeatherDetailsViewController: UIViewController {
    
    //outlets:
    @IBOutlet weak var tempartureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var minTempratureLbl: UILabel!
    @IBOutlet weak var maxTempratureLbl: UILabel!
    @IBOutlet weak var weatherDescLbl: UILabel!
    
    //variables:
    private var viewModel: CityWeatherDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignValues()
    }
    
    func assignValues() {
        self.title = self.viewModel?.name()
        self.tempartureLbl.text = "\(String(describing: self.viewModel!.temprature())) °C"
        self.minTempratureLbl.text = "\(String(describing: self.viewModel!.minTemprature())) °C"
        self.maxTempratureLbl.text = "\(String(describing: self.viewModel!.maxTemprature())) °C"
        self.humidityLbl.text = "\(String(describing: self.viewModel!.humidity())) %"
        self.weatherDescLbl.text = self.viewModel!.weatherDescription()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- initialization
    public func initializeViewModel(_ viewModel: CityWeatherDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK:- actions
    @IBAction func doneBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
