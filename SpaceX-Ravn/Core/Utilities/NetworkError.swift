//
//  NetworkError.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case serverError
    case dataNotFound
}
