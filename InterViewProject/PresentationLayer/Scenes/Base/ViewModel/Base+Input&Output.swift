//
//  Base+Input&Output.swift
//  TurkcellAssignment
//
//  Created by Abdullah Okudan on 16.03.2022.
//

import Foundation

protocol BaseInput: AnyObject {

}

protocol BaseOutput: AnyObject {
    func didUpdateState()
}
