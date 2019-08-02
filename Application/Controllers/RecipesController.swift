//
//  ReceiptsController
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/5/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct RecipesController {
    
    private static let queue = DispatchQueue(label: "com.gorilla.letscook.receiptscontroller")
    
    static func getAllRecipes(completion: @escaping ([Recipe]) -> ()) {
        let request = API.getAllRecipes(parameters: nil)
        Alamofire.request(request).validate().responseJSON(queue: queue) { response in
            if response.error != nil {
                return
            }
            guard let value = response.result.value as? [[String: Any]],
                let recipes = Mapper<Recipe>().mapArray(JSONObject: value) else { return }
            completion(recipes)
        }
    }
    
    static func getReceiptById(id: Int , completion: @escaping (RecipeDetail) -> ()) {
        let request = API.getRecipe(recipeId: id)
        Alamofire.request(request).validate().responseJSON(queue: queue) { response in
            if response.error != nil {
                return
            }
            guard let value = response.result.value as? [String: Any],
                let recipeDetail = Mapper<RecipeDetail>().map(JSON: value) else { return }
            completion(recipeDetail)
        }
    }
}
