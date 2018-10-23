//
//  ContributorObject.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2018/10/19.
//  Copyright © 2018 Keita Watanabe. All rights reserved.
//

import Foundation
import RealmSwift

class ContributorObject : Object, Compatible, Uniquable {
    typealias Value = Contributor
    var primaryKey: String {
        return String(id.value!)
    }
    
    @objc dynamic var login: String!
    let id = RealmOptional<Int>()
    @objc dynamic var nodeId: String!
    @objc dynamic var avatarUrl: String!
    @objc dynamic var gravatarId: String!
    @objc dynamic var url: String!
    @objc dynamic var htmlUrl: String!
    @objc dynamic var followersUrl: String!
    @objc dynamic var followingUrl: String!
    @objc dynamic var gistsUrl: String!
    @objc dynamic var starredUrl: String!
    @objc dynamic var subscriptionsUrl: String!
    @objc dynamic var organizationsUrl: String!
    @objc dynamic var reposUrl: String!
    @objc dynamic var eventsUrl: String!
    @objc dynamic var receivedEventsUrl: String!
    @objc dynamic var type: String!
    let siteAdmin = RealmOptional<Bool>()
    let contributions = RealmOptional<Int>()
    
    convenience required init(from c: Contributor) {
        self.init()
        
        login = c.login
        id.value = c.id
        nodeId = c.nodeId
        avatarUrl = c.avatarUrl
        gravatarId = c.gravatarId
        url = c.url
        htmlUrl = c.htmlUrl
        followersUrl = c.followersUrl
        followingUrl = c.followingUrl
        gistsUrl = c.gistsUrl
        starredUrl = c.starredUrl
        subscriptionsUrl = c.subscriptionsUrl
        organizationsUrl = c.organizationsUrl
        reposUrl = c.reposUrl
        eventsUrl = c.eventsUrl
        receivedEventsUrl = c.receivedEventsUrl
        type = c.type
        siteAdmin.value = c.siteAdmin
        contributions.value = c.contributions
    }
    
    func to() -> Contributor {
        return Contributor(
            login: login,
            id: id.value!,
            nodeId: nodeId,
            avatarUrl: avatarUrl,
            gravatarId: gravatarId,
            url: url,
            htmlUrl: htmlUrl,
            followersUrl: followersUrl,
            followingUrl: followingUrl,
            gistsUrl: gistsUrl,
            starredUrl: starredUrl,
            subscriptionsUrl: subscriptionsUrl,
            organizationsUrl: organizationsUrl,
            reposUrl: reposUrl,
            eventsUrl: eventsUrl,
            receivedEventsUrl: receivedEventsUrl,
            type: type,
            siteAdmin: siteAdmin.value!,
            contributions: contributions.value!
        )
    }
}
