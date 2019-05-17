//
//  flickerNetwork.swift
//  FlickerApp
//
//  Created by Pritesh Khandelwal on 14/05/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//


//netowrk class for api call
import Foundation

class FlickerApi{
    
    class func fetchImageData(pageNumber:Int,searchString:String,success:@escaping (ApiResponse) -> Void, failure:@escaping (Error) -> Void){
        let url = Constant.apiUrl + "&api_key=" + Constant.apiKey + "&format=json&nojsoncallback=1&safe_search=1&text=\(searchString)&page=\(pageNumber)&per_page=20"
        print(url)
        guard let gitUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response,error) in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                let mainResponse = try decoder.decode(ApiResponse.self, from: data)
                success(mainResponse)
            }catch let error {
                print("Err", error)
                failure(error)
            }
            }.resume()
    }
    
}
