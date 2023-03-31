//
//  ViewController.swift
//  DessertFetcher
//
//  Created by Sproull Student on 3/30/23.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableLength: Int!
    var mealList: [Meal] = []

 
    @IBOutlet var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        // Create a spinner and add it to the view
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .gray
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        
        // Start the spinner animation and fetch the data
        spinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            fetchData(from: url) {
                data in
                self.mealList = data
                DispatchQueue.main.async {
                    spinner.stopAnimating()
                    self.tableView.reloadData()
                }

                
            }
        }
    }
    let url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    private 

    
    func setupTableView() {
        tableView.dragInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //mealList[indexPath.row].strMeal
        cell.textLabel?.text = mealList[indexPath.row].strMeal
        print(indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        detailedVC.meal = mealList[indexPath.row]
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }


}






