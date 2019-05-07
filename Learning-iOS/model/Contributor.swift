//
//  Contributor.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/15.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation

struct Contributor : Codable {
    private enum CodingKeys : String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case contributions
    }
    
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool
    let contributions: Int
    
    init(
        login: String,
        id: Int,
        nodeId: String,
        avatarUrl: String,
        gravatarId: String,
        url: String,
        htmlUrl: String,
        followersUrl: String,
        followingUrl: String,
        gistsUrl: String,
        starredUrl: String,
        subscriptionsUrl: String,
        organizationsUrl: String,
        reposUrl: String,
        eventsUrl: String,
        receivedEventsUrl: String,
        type: String,
        siteAdmin: Bool,
        contributions: Int
    ) {
        self.login = login
        self.id = id
        self.nodeId = nodeId
        self.avatarUrl = avatarUrl
        self.gravatarId = gravatarId
        self.url = url
        self.htmlUrl = htmlUrl
        self.followersUrl = followersUrl
        self.followingUrl = followingUrl
        self.gistsUrl = gistsUrl
        self.starredUrl = starredUrl
        self.subscriptionsUrl = subscriptionsUrl
        self.organizationsUrl = organizationsUrl
        self.reposUrl = reposUrl
        self.eventsUrl = eventsUrl
        self.receivedEventsUrl = receivedEventsUrl
        self.type = type
        self.siteAdmin = siteAdmin
        self.contributions = contributions
    }
}
