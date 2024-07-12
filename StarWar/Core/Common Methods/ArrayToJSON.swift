//
//  JSONCoding.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 12.07.24.
//

import Foundation

func encodeArrayToJSON(_ array: [Int]) -> String? {
    let encoder = JSONEncoder()
    if let data = try? encoder.encode(array) {
        return String(data: data, encoding: .utf8)
    }
    return nil
}

func decodeJSONToArray(_ jsonString: String) -> [Int]? {
    let decoder = JSONDecoder()
    if let data = jsonString.data(using: .utf8),
       let array = try? decoder.decode([Int].self, from: data) {
        return array
    }
    return nil
}
