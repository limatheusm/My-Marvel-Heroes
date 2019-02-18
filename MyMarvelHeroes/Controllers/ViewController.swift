//
//  ViewController.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 15/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MarvelAPIManager.sharedInstance.getHeroes(completion: { (result) in
            switch result {
            case .success(let heroesData):
                for hero in heroesData.results! {
                    print(hero.name ?? "Unknown")
                }
            case .failure(let errorString):
                print(errorString)
            }
        })
    }


}

