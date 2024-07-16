//
//  ViewModal.swift
//  NetworkLayerProject
//
//  Created by Mayank Barnwal on 25/05/24.
//

import Foundation

struct WeatherResponse: Decodable {
    var main: Main
}

struct Main: Decodable {
    var tempMin: Double
    var tempMax: Double
}

class ViewModal:NSObject{
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    init(eventHandler: (@escaping (_: Event) -> Void)){
        self.eventHandler = eventHandler
    }
    
    var responseData:Main!
    
    private override init() {}
    
    
    func getData(){
        var url = URL.init(string: "https://api.openweathermap.org/data/2.5/weather" + queryItems(dictionary: ["lat" : "28.7041",
                                                                                                               "lon" : "28.7041",
                                                                                                               "units" : "metric",
                                                                                                               "appid" : "26f1ffa29736dc1105d00b93743954d2"]))
        
        eventHandler?(.loading)
        
        NetworkLayer.shared.request(url: url, expecting: WeatherResponse.self) {[weak self] response, error in
            DispatchQueue.main.async {[weak self] in
                guard let self else{
                    self?.eventHandler?(.errorInLoading)
                    return
                }
                guard let response else{
                    eventHandler?(.errorInLoading)
                    return
                }
                responseData = response.main
                eventHandler?(.loaded)
            }
            
        }
    }
    
    func queryItems(dictionary: [String:Any]) -> String {
        var components = URLComponents()
        print(components.url!)
        components.queryItems = dictionary.map {
            URLQueryItem(name: $0, value: $1  as? String)
        }
        return (components.url?.absoluteString)!
    }
}

extension ViewModal{
    enum Event{
        case loading
        case loaded
        case errorInLoading
    }
}
