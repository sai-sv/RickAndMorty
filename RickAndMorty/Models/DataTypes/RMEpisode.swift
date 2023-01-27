//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import Foundation

struct RMEpisode: Codable, RMEpisodeDataRenderProtocol {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
