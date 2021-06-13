//
//  Webservice.swift
//  IOSProficiencyExercise
//
//  Created by Jaydip Godhani on 13/06/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case responseError
}

class WebService {
    
    
    /// / This function is used for all get methods
    /// - Parameters:
    ///   - urlString: URL String of the api
    ///   - completionHandler: when api called success that completionHandler called with success and error in `Result`
    func getMethod<T: Decodable>(urlString: String, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        //// Check the given url is perfect or not, If url is not perfect then return `bad url` exception in result
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        print("URL : \(urlString)")
    
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let obtainedData = data else { return debugPrint("No data")}
            //// This data having some issue so first need to convert it into the string and then covert string into the `Data` and then `decode` the generic data type
            let str = String(decoding: obtainedData, as: UTF8.self)
            do {
                let decodableResponse = try JSONDecoder().decode(T.self, from: str.data(using: .utf8)!)
                DispatchQueue.main.async {
                    completionHandler(.success(decodableResponse))
                }
            } catch {
                //// User Debug print because `production` not affect
                debugPrint(error)
                completionHandler(.failure(.responseError))
            }
        }.resume()
        
        
    }
    
}
