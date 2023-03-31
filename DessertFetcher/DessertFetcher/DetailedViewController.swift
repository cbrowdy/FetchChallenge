//
//  DetailedViewController.swift
//  DessertFetcher
//
//  Created by Sproull Student on 3/30/23.
//

import UIKit

class DetailedViewController: UIViewController {
    var meal: Meal!
    var aMeal: [[String: String?]]!

    @IBOutlet weak var ingredientList2: UIStackView!
    @IBOutlet weak var ingredientList: UIStackView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var instructions: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.meal.idMeal)
        let url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(self.meal.idMeal)"
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            fetchDataID(from: url) {
                data in
                self.aMeal = data
                DispatchQueue.main.async {
                    self.setName()
                    self.setInstructions()
                    self.setIngredients()
                }

            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    func setName() {
        if let mealName = aMeal[0]["strMeal"] as? String {
            name.text = mealName
        }
    }
    func setInstructions() {
        instructions.text = aMeal[0]["strInstructions"] as? String
    }
    func setIngredients() {
        for (index, view) in ingredientList.arrangedSubviews.enumerated() {
            if let label = view as? UILabel {
                let ingredient = aMeal[0]["strIngredient\(index+1)"] as? String
                label.text = ingredient ?? ""
            }
        }
        for (index, view) in ingredientList2.arrangedSubviews.enumerated() {
            if let label = view as? UILabel {
                let ingredient = aMeal[0]["strIngredient\(index+5)"] as? String
                label.text = ingredient ?? ""
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
