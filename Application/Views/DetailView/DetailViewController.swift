//
//  MainViewController.swift
//  GorillaTest
//
//  Created by David Figueroa on 8/1/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit
import Cosmos
import AlamofireImage

class DetailViewController: UIViewController {
    
    var recipeId: Int?
    var recipe: RecipeDetail?
    
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var detail: UITextView?
    @IBOutlet weak var ratingStars: CosmosView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.titleView?.backgroundColor = hexToUIColor(hex: "#FC941C") //YELLOW
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = hexToUIColor(hex: "#FC941C") //YELLOW
        self.navigationController?.navigationBar.tintColor = .white
        
        RecipesController.getReceiptById(id: recipeId ?? 0) { recipeDetail in
            self.recipe = recipeDetail
            DispatchQueue.main.async {
                self.setupViews()
            }
        }
    }

    
    func setupViews(){
        
        self.navigationItem.title = recipe?.title ?? ""
        
        image?.contentMode = .scaleAspectFit
        detail?.text = recipe?.instructions
        ratingStars?.rating = Double(recipe?.rating ?? 0)
        guard let url = URL(string:recipe?.image ?? "") else { return }
        image?.af_setImage(withURL: url)
        
    }
    
}
