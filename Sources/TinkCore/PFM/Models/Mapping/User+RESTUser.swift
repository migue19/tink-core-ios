extension User {
    init(restUser: RESTUser) {
        self.created = restUser.created
        self.id = .init(restUser.id)
        self.profile = .init(restUserProfile: restUser.profile)
        self.username = restUser.username
        self.nationalID = restUser.nationalId
    }
}
