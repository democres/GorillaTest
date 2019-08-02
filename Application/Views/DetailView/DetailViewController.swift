//
//  MainViewController.swift
//  GorillaTest
//
//  Created by David Figueroa on 8/1/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit
import Cosmos

class DetailViewController: UIViewController {
    
    var recipeId: Int?
    
    var recipe: RecipeDetail?
    
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var detail: UITextView?
    @IBOutlet weak var ratingStars: CosmosView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        RecipesController.getReceiptById(id: recipeId ?? 0) { recipeDetail in
            self.recipe = recipeDetail
            
            self.setupViews()
        }
    }
    
    func setupViews(){
        
        DispatchQueue.main.async {
            detail?.text = recipe?.instructions
            ratingStars?.rating = Double(recipe?.rating ?? 0)
        }
    }
    
}
