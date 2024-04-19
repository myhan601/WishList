//
//  RemoteProduct.swift
//  WishList
//
//  Created by 한철희 on 4/19/24.
//

import Foundation

// URLSession을 통해 가져올 상품의 Decodable Model
struct RemoteProduct: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: URL
}
