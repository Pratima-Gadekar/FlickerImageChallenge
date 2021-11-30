//
//  String+Extensions.swift
//  DeserveCodeChallenge
//
//  Created by pratima gadekar on 29/11/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

protocol SearchTextSpaceRemover{}

extension String: SearchTextSpaceRemover {
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension SearchTextSpaceRemover where Self == String {
    
    //MARK: - Removing space from String
    var removeSpace: String {
        if self.isNotEmpty {
           return self.components(separatedBy: .whitespaces).joined()
        }else{
           return ""
        }
    }
}
