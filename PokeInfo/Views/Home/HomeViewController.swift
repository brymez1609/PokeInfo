//
//  ViewController.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/21/21.
//

import UIKit
import SOTabBar

class HomeViewController: SOTabBarController {
    override func loadView() {
        super.loadView()
        SOTabBarSetting.tabBarTintColor = #colorLiteral(red: 2.248547389e-05, green: 0.7047000527, blue: 0.6947537661, alpha: 1)
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pokedexViewController = UIStoryboard(name: "Pokedex", bundle: nil).instantiateViewController(withIdentifier: "PokedexID")
        let likeViewController = UIStoryboard(name: "Like", bundle: nil).instantiateViewController(withIdentifier: "LikeID")
        let votedViewController = UIStoryboard(name: "Voted", bundle: nil).instantiateViewController(withIdentifier: "VotedID")
      
        pokedexViewController.tabBarItem = UITabBarItem(title: "Pokedex", image: UIImage(named: "smartphone"), selectedImage: UIImage(named: "smartphone"))
        likeViewController.tabBarItem = UITabBarItem(title: "Like", image: UIImage(named: "love"), selectedImage: UIImage(named: "love"))
        votedViewController.tabBarItem = UITabBarItem(title: "Voted", image: UIImage(named: "pikachu"), selectedImage: UIImage(named: "pikachu"))
        viewControllers = [pokedexViewController, likeViewController,votedViewController]
    }


}

