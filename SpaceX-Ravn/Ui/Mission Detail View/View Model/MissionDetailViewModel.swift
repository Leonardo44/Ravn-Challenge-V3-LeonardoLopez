//
//  MissionDetailViewModel.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import Foundation
import Combine
import SpaceXRavnAPI

protocol MissionDetailViewModelI: AnyObject {
    associatedtype LaunchObject
    associatedtype DataStatus
    associatedtype Service
    
    var launchId: String { get set }
    var detailLaunch: LaunchObject? { get set }
    var dataStatus: CurrentValueSubject<DataStatus, Never> { get set }
    var service: Service { get set }
    var subscriptions: Set<AnyCancellable> { get set }
    var dateFormatter: DateFormatter { get set }
    
    func fetchDetail()
    func extractYoutubeIdFromLink(link: String) -> String?
}

class MissionDetailViewModel: MissionDetailViewModelI, ObservableObject {
    typealias LaunchObject = LaunchQuery.Data.Launch
    typealias DataStatus = NetworkDataStatus
    typealias Service = MissionService
    
    @Published var detailLaunch: LaunchObject?
    var launchId: String
    var dataStatus: CurrentValueSubject<NetworkDataStatus, Never>
    var service: MissionService
    var subscriptions: Set<AnyCancellable>
    var dateFormatter: DateFormatter
    
    init(launchId: String, detailLaunch: LaunchQuery.Data.Launch?, subscriptions: Set<AnyCancellable>, dataStatus: CurrentValueSubject<NetworkDataStatus, Never>, service: MissionService, dateFormatter: DateFormatter) {
        self.launchId = launchId
        self.detailLaunch = detailLaunch
        self.subscriptions = subscriptions
        self.dataStatus = dataStatus
        self.service = service
        self.dateFormatter = dateFormatter
    }
    
    deinit {
        #if DEBUG
            print("MissionDetailViewModel - deinit")
        #endif
    }
    
    public func fetchDetail() {
        if dataStatus.value != .loading {
            dataStatus.send(.loading)
            
            service.fetchLauncDetail(id: launchId)
                .receive(on: DispatchQueue.main, options: .none)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.dataStatus.send(.success)
                    case .failure(_):
                        self?.dataStatus.send(.error)
                    }
                }, receiveValue: { [weak self] data in
                    self?.detailLaunch = data
                })
                .store(in: &subscriptions)
        }
    }
    
    public func extractYoutubeIdFromLink(link: String) -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        
        let nsLink = link as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0, length: nsLink.length)
        let matches = regExp.matches(in: link as String, options:options, range:range)
        
        if let firstMatch = matches.first {
            return nsLink.substring(with: firstMatch.range)
        }
        
        return nil
    }
}
