//
//  Process.swift
//  Unsplash
//
//  Created by Pin Lu on 4/19/23.
//

import Foundation

enum Process {
    case ready
    case inProcess
    case finished
    case finishedWithEmptyResult
    case failedWithError(error: Error)
}
