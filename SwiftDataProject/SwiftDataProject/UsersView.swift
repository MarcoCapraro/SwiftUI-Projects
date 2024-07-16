//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Marco Capraro on 7/16/24.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            HStack(alignment: .center) {
                Text(user.name)
                Spacer()
                Text(user.joinDate.formatted(date: .abbreviated, time: .omitted))
            }
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        // _users will modify the underlining SwiftData Query
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
