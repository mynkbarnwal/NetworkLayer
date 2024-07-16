//
//  GetAPI.swift
//  NetworkLayerProject
//
//  Created by Mayank Barnwal on 25/05/24.
//

import UIKit

class NetworkLayer: NSObject {
    
    static let shared = NetworkLayer()
    
    private var session:URLSession! {
        URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
    }
    
    private lazy var certificates: [Data] = {
        let url = Bundle.main.url(forResource: "openweathermap.org", withExtension: "cer")!
        let data = try! Data(contentsOf: url)
        return [data]
    }()
    
    private override init() {
        
    }
    
    func request<T : Decodable>(url:URL?, expecting:T.Type, completion: @escaping (_ data :T?, _ error :Error?) -> ()){
        guard let url else{
            print("Not a valid url")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.httpMethod = "GET"
        
        session.dataTask(with: url) { data, response, error in
            
            if let error{
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            
            guard let data else{
                print("Something is wrong try again")
                completion(nil, error)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                print("Function: \(#function) = data = \(String(decoding: data, as: UTF8.self))")
                
                let response = try decoder.decode(T.self, from: data)
                completion(response, nil)
            }
            catch{
                print(error)
                completion(nil, error)
            }
        }.resume()
    }
}

extension NetworkLayer:URLSessionDelegate{
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if let trust = challenge.protectionSpace.serverTrust,
           SecTrustGetCertificateCount(trust) > 0 {
            
            if let certificate = SecTrustGetCertificateAtIndex(trust, 0) {
                let data = SecCertificateCopyData(certificate) as Data
                
                if certificates.contains(data) {
                    print("Trusted")
                    completionHandler(.useCredential, URLCredential(trust: trust))
                    return
                } else {
                    print("Invalid")
                    completionHandler(.cancelAuthenticationChallenge, URLCredential(trust: trust))
                    return
                }
            }
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}



