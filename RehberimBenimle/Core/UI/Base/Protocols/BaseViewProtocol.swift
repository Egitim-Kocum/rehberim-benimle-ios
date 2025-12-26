//
//  BaseViewProtocol.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 25.12.2025.
//

@MainActor
protocol BaseViewProtocol: AnyObject {
    func render(state: LoadingState)
}

enum LoadingState {
    case idle
    case loading
    case success
    case error(String)
}
