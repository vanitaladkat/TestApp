//
//  WeatherDataViewController.swift
//  TestApp
//
//  Created by Vanita on 11/8/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import UIKit
import Firebase

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

class WeatherDataViewController: UIViewController {

    //outlets:
    @IBOutlet weak var weatherDataTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //variables:
    private var viewModel = WeatherDataViewModel()
    

    let normalBtn: UIButton = {
        let button = UIButton()
        
        button.frame = CGRect(x: 80, y: 200, width: 200, height: 100)
        
        button.setTitle("🙂", for: .normal)
        button.setTitle("😆", for: .highlighted)
        button.setTitle("😆", for: UIControlState.selected.union(.highlighted))
        button.setTitle("😍", for: .selected)
        button.setTitle("😂", for: .focused)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent("notification_opened", parameters: nil)
        
        
        let nearestStarNames = ["Proxima Centauri", "Alpha Centauri A", "Alpha Centauri B", "Barnard's Star", "Wolf 359"]
        let nearestStarDistances = [4.24, 4.37, 4.37, 5.96, 7.78, 6.232]
        // Dictionary from sequence of keys-values
        let starDistanceDict = Dictionary(uniqueKeysWithValues: zip(nearestStarNames, nearestStarDistances))
        print(starDistanceDict)
        
        
        
        
        
        let star = "⭐️"
        let introString = """
        A long time ago in a galaxy far, \nfar away....
        
        You could write multi-lined strings
        without "escaping" single quotes.
        
        The indentation of the closing quotes
        below deside where the text line
        begins.
        
        You can even dynamically add values
        from properties: \(star)
        """
//        print(introString)
        
        
        
        view.addSubview(normalBtn)
        
        normalBtn.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        
        
        setUpView()
        setUpViewModel()
        
        var somepoint = Point(x: 1, y: 1)
        somepoint.x += 3
        somepoint.y += 5
        
        let fixedPoint = Point(x: 3.0, y: 3.0)
//        fixedPoint.moveBy(x: 2.0, y: 3.0)
        // this will report an error

    }
    
    @objc func btnSelected() {
        normalBtn.isSelected = !normalBtn.isSelected
        print("highlight", normalBtn.isHighlighted)
    }



    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - initialzation
    func setUpViewModel() {
        self.viewModel.delegate = self //to get the event trigger for fetched data: to update view
    }
    
    func setUpView() {
        self.title = "Weather"
        self.weatherDataTableView.tableFooterView = UIView() //hide extra cells
    }
    
    @objc func updateView() {
        //stop indicator
        self.activityIndicator.stopAnimating()
        //reload data
        self.weatherDataTableView.reloadData()
    }
    
    //MARK:-  navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let navController = segue.destination as? UINavigationController
            let cityWeatherDetailsVC = navController?.viewControllers[0] as? CityWeatherDetailsViewController
            cityWeatherDetailsVC?.initializeViewModel(self.viewModel.getDetailsViewModelWithData())
        }
    }
}

//MARK:- WeatherDataViewModelDelegate
extension WeatherDataViewController: WeatherDataViewModelDelegate {
    func weatherDataViewModelFetchedData(_ weatherDataViewModel: WeatherDataViewModel) {
        self.performSelector(onMainThread: #selector(self.updateView), with: nil, waitUntilDone: false)
    }
}

//MARK:- tableview delegate
extension WeatherDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCellID")
        self.viewModel.configureCell(cell: cell!, at: indexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "detailsSegue", sender: self)
    }
}
