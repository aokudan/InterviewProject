//
//  LoadTestData.swift
//  TurkcellAssignmentTests
//
//  Created by Abdullah Okudan on 16.03.2022.
//

import Foundation
import XCTest

class LoadTestData {
    
    static func readLocalFile(_ name: String, withExtension: String) -> Data? {
        guard let url = Bundle(for: Self.self)
                .url(forResource: name, withExtension: withExtension) else { return nil }
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("File \(name) not found.")
            return nil
        }
        return data
    }
}
