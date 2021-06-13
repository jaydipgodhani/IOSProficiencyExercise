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
    
    var title: String = ""
    var arrayFacts: [Facts] = []
    
    //MARK:- Observer
    var observerFactsFetchSuccess: () -> Void = { }
    
    //MARK:- Get facts
    //// Get facts
    func getFacts() {
        wc.getMethod(urlString: API_ENDPOINT.facts) { (result : Result<FactsResponseModel, NetworkError>) in
            switch result {
            case .success(let factsResponse):
                //// Set the title and array facts and then call observer
                self.title = factsResponse.title
                self.arrayFacts = factsResponse.facts
                self.observerFactsFetchSuccess()
                break
            case .failure(let error):
                debugPrint(">>> Get Facts Error : \(error)")
                break
            }
        }
    }
    
    
    
    //MARK:- Access view model data
    var numberOfFacts: Int {
        return arrayFacts.count
    }
    func facts(index: Int) -> Facts {
        return arrayFacts[index]
    }
}
