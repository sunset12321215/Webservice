//
//  URL.swift
//  Webservice
//
//  Created by CuongVX-D1 on 6/21/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import Foundation

struct URLs {
    private static let baseURL = "https://reqres.in/api/"
    static let post = baseURL + "users"
    static let users = baseURL + "users?page="
}
