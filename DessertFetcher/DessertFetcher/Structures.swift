//
//  Structures.swift
//  DessertFetcher
//
//  Created by Sproull Student on 3/30/23.
//

import Foundation

func fetchData(from url: String, comp : @escaping ([Meal])->()) {
    let task = URLSession.shared.dataTask(with: URL(string: url)!,completionHandler: { data, response, error in
        guard let data = data, error == nil else {
            print("not working")
            return
        }
    
        do {
            let result = try JSONDecoder().decode(Response.self, from: data)
            comp(result.meals)
        }
        catch {
            print("failed to convert")
        }
        
    })
    task.resume()
}

func fetchDataID(from url: String, comp : @escaping ([[String: String?]])->()) {
    let task = URLSession.shared.dataTask(with: URL(string: url)!,completionHandler: { data, response, error in
        guard let data = data, error == nil else {
            print("not working")
            return
        }
    
        do {
            let result = try JSONDecoder().decode(ResponseID.self, from: data)
            comp(result.meals)
        }
        catch {
            print("failed to convert")
        }
        
    })
    task.resume()
}

struct Response : Codable {
    let meals: [Meal]
}

struct ResponseID : Codable {
    let meals: [[String: String?]]
}

struct Meal : Codable {
    let strMeal: String?
    let strMealThumb: String
    let idMeal: String
}
