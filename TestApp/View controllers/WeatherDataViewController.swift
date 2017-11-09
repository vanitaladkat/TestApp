//
//  WeatherDataViewController.swift
//  TestApp
//
//  Created by Vanita on 11/8/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import UIKit

class WeatherDataViewController: UIViewController {

    //outlets:
    @IBOutlet weak var weatherDataTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //variables:
    private var viewModel = WeatherDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpViewModel()
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
