//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by Brian Ortiz on 2023-08-07.
//  Copyright © 2023 Sergey Kargopolov. All rights reserved.
//

import Foundation


class SignupWebService {
    
    private var urlString: String
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = URLSession.shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signUpWithForm(_ form: SignupRequestModel, completion: @escaping(SignupResponseModel?, SignupError?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, .invalidUrl)
            return
        }
 
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(form)
        
        urlSession.dataTask(with: request) { data, response, error in
            
            if let requestError = error {
                print(requestError.localizedDescription)
                completion(nil, .failedRequest(description: "Error localized description"))
                return
            }
            
            if let jsonData = data {
                do {
                    let modelResponse = try JSONDecoder().decode(SignupResponseModel.self, from: jsonData)
                    completion(modelResponse, nil)
                } catch {
                    print("Error decoding: \(error)")
                    completion(nil, .responseModelParsingError)
                }
            }
            
        }.resume()
    }
}
