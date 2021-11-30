//
//  Photos.swift
//  DeserveCodeChallenge
//
//  Created by pratima gadekar on 29/11/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

struct Photos: Decodable {
  public let photos: PhotosDto
  public let stat: String
}

struct PhotosDto: Decodable {
  public let page: Int
  public let pages: Int
  public let perpage: Int
  public let total: Int
  public let photo: [Photo]
}

struct Photo: Decodable, PhotoURL {
  public let id, owner, secret, server: String
  public let farm: Int
  public let title: String
  public let ispublic, isfriend, isfamily: Int
}

protocol PhotoURL {}

extension PhotoURL where Self == Photo{
    
    func getImagePath() -> URL?{
        let path = "http://farm\(self.farm).static.flickr.com/\(self.server)/\(self.id)_\(self.secret).jpg"
        return URL(string: path)
    }
    
}

