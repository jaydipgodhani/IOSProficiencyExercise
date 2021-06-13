//
//  HomeViewModel.swift
//  IOSProficiencyExercise
//
//  Created by Jaydip Godhani on 13/06/21.
//

import Foundation

class HomeViewModel {
    
    //MARK:- Variable
    //// Define all variable here
    
    //// Init the `WebService` class for user it's functions
    let wc = WebService()
    
    
    //// Get facts
    func getFacts() {
        wc.getMethod(urlString: API_ENDPOINT.facts) { (result : Result<FactsResponseModel, NetworkError>) in
            switch result {
            case .success(let factsResponse):
                debugPrint(">>> Get Facts : \(factsResponse)")
                break
            case .failure(let error):
                debugPrint(">>> Get Facts Error : \(error)")
                break
            }
        }
    }
    
}
