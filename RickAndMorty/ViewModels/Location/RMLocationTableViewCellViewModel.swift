//
//  RMLocationTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 04.02.2023.
//

import Foundation

struct RMLocationTableViewCellViewModel: Hashable {
    
    // MARK: - Public Properties
    var name: String {
        return location.name
    }
    
    var type: String {
        return location.type
    }
    
    var dimension: String {
        return location.dimension
    }
    
    // MARK: - Private Properties
    private var location: RMLocation
    
    // MARK: - Init
    init(location: RMLocation) {
        self.location = location
    }
    
    // MARK: - Public Methods
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(dimension)
        hasher.combine(location.id)
    }
}
