//
//  MainViewController.swift
//  GorillaTest
//
//  Created by David Figueroa on 8/1/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var tableView: UITableView?
    
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        colorAnimations()
        self.hideKeyboardWhenTappedAround()
        setupViews()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 66
        loadReceipts()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func loadReceipts(){
        RecipesController.getAllRecipes { receipts in
            self.recipes = receipts
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    func setupViews(){
    
        //SEARCH ICON FOR THE TEXTFIELD
        textField?.rightViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "searchIcon")
        imageView.tintColor = .gray
        textField?.rightView = imageView
        
        
    }
    
    func colorAnimations(){
        
        //Background
        UIView.animate(withDuration: 1.5, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.allowUserInteraction], animations: {
            
            self.view.backgroundColor = hexToUIColor(hex: "#FC941C") //YELLOW
            self.view.backgroundColor = hexToUIColor(hex: "#fdb768") //LIGHT YELLOW
            
        }, completion: nil)
        
    }
    

}

extension MainViewController: UITextFieldDelegate{
    //MARK: TextField Delegates
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

}


extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! MainTableViewCell
        cell.title?.text = self.recipes[indexPath.row].title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        viewController.recipeId = self.recipes[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

