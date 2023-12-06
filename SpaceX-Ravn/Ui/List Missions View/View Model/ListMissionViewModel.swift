//
//  ListMissionViewModel.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import Foundation
import Combine
import SpaceXRavnAPI

protocol ListMissionViewModelI: AnyObject {
    associatedtype LaunchObject
    associatedtype DataStatus
    associatedtype Service
    
    var launches: [LaunchObject] { get set }
    var originalList: [LaunchObject] { get set }
    var textSearch: String { get set }
    var dataStatus: CurrentValueSubject<DataStatus, Never> { get set }
    var service: Service { get set }
    var subscriptions: Set<AnyCancellable> { get set }
    var dateFormatter: DateFormatter { get set }
    
    func fetchList()
    func fetchElementByText(_ text: String)
}

class ListMissionViewModel: ListMissionViewModelI, ObservableObject {
    typealias LaunchObject = LaunchesQuery.Data.Launch
    typealias DataStatus = NetworkDataStatus
    typealias Service = MissionService
    
    @Published var launches: [LaunchesQuery.Data.Launch]
    @Published var textSearch: String
    var originalList: [LaunchObject]
    var dataStatus: CurrentValueSubject<NetworkDataStatus, Never>
    var service: MissionService
    var subscriptions: Set<AnyCancellable>
    var dateFormatter: DateFormatter
    
    init(launches: [LaunchesQuery.Data.Launch], subscriptions: Set<AnyCancellable>, dataStatus: CurrentValueSubject<NetworkDataStatus, Never>, service: MissionService, textSearch: String, dateFormatter: DateFormatter) {
        self.launches = launches
        self.originalList = launches
        self.subscriptions = subscriptions
        self.dataStatus = dataStatus
        self.service = service
        self.textSearch = textSearch
        self.dateFormatter = dateFormatter
        
        $textSearch
            .removeDuplicates()
            .debounce(for: .seconds(0.7), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                if !value.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self?.fetchElementByText(value.lowercased())
                } else {
                    self?.launches = self?.originalList ?? []
                }
            })
            .store(in: &self.subscriptions)
    }
    
    deinit {
        #if DEBUG
            print("ListMissionViewModel - deinit")
        #endif
    }
    
    public func fetchList() {
        if dataStatus.value != .loading {
            dataStatus.send(.loading)
            
            service.fetchLauncList()
                .receive(on: DispatchQueue.main, options: .none)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.dataStatus.send(.success)
                    case .failure(_):
                        self?.dataStatus.send(.error)
                    }
                }, receiveValue: { [weak self] data in
                    self?.launches = data
                    self?.originalList = data
                })
                .store(in: &subscriptions)
        }
    }
    
    public func fetchElementByText(_ text: String) {
        launches = originalList.filter({ $0.mission_name?.lowercased().contains(text) == true })
    }
}
