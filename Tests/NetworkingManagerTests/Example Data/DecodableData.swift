//
//  DecodableData.swift
//  NetworkingManager
//
//  Created by Kade Walter on 7/2/25.
//

import Foundation

struct DecodableData: Decodable {
    var data: [DataInfo]
}

struct DataInfo: Decodable {
    var name: String
    var value: Int
}
