//
//  ModelConvertible.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 14.03.2022.
//

import Foundation

/// Protocol to provide functionality for data model conversion.
protocol ModelConvertible {
    associatedtype Model

    /// Converts a conforming instance to a data model instance.
    ///
    /// - Returns: The converted data model instance.
    func toModel() -> Model?
}
