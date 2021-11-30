//
//  Router.swift
//  DeserveCodeChallenge
//
//  Created by pratima gadekar on 29/11/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation


class Router: RequestFlickrImages{
    
    //Replace your Flickr Key here
    fileprivate let flickrKey = "2932ade8b209152a7cbb49b631c4f9b6"
    var requestCancelStatus = false
    
    enum Result<value>{
        case success(value)
        case failure(Error?)
    }
    
    fileprivate var task: URLSessionTask?
    
    //MARK: - Make URL here based on keyword & page counts
    fileprivate func getURLPath(_ pageCount: String, and text: String) -> URL?{
        guard let urlPath = URL(string:"https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(flickrKey)&format=json&nojsoncallback=1&safe_search=\(pageCount)&text=\(text)") else {
            return nil
        }
        return urlPath
    }
    
    //MARK: - Cancel all previous tasks
    func cancelTask(){
        requestCancelStatus = true
        task?.cancel()
    }
    
}

extension Router: SearchTextSpaceRemover{
    
    func requestFor(text: String, with pageCount: String, completionHandler: @escaping(Result<[Photo]>) -> Void){
        
        //Removing here keywords spaces
        let keyword = text.removeSpace
        guard keyword.count != 0 , let urlPath = getURLPath(pageCount, and: keyword) else { return }
        
        //Set timeout for request
        requestTimeOut()
        
      task = URLSession.shared.dataTask(with: urlPath) { photos, response, error in
            DispatchQueue.main.async {[weak self] in
                guard error == nil,
                    let result = photos else {
                        self?.requestCancelStatus = false
                        completionHandler(.failure(error))
                        return
                }
              let decoder = JSONDecoder()
              guard let photosArray = try? decoder.decode(Photos.self, from: result) else {
                return
              }
              let ImageData =  photosArray.photos.photo
              completionHandler(.success(ImageData))
            }
      }
              
        task?.resume()
    }
    
    fileprivate func requestTimeOut(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(20), execute: {[weak self] in
            self?.task?.resume()
        })
    }
}


