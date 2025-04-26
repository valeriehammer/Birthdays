//
//  ContentView.swift
//  Birthdays
//
//  Created by Valerie Hammer on 4/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @State private var selectedFriend: Friend?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    HStack{
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    }
                    //  end HStack
                    .onTapGesture {
                        selectedFriend = friend
                    }
                    // end Tap Gesture
                }
                // end ForEach(friends)
                .onDelete(perform: deleteFriend)
            }
            // endList
            
            .navigationTitle("Birthdays")
            .sheet(item: $selectedFriend) { friend in
                NavigationStack {
                    EditFriendView(friend: friend)
                }
                // end Navigation Stack
            }
            // end .sheet
                
            .safeAreaInset(edge: .bottom) {
                VStack{
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date){
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                        //end DatePicker
                        Button("Save"){
                            let newFriend = Friend(name: newName, birthday: newBirthday)
                            context.insert(newFriend)
                            newName = ""
                            newBirthday = Date.now
                            
                        }
                        .bold()
                        //end Button
                    }
                    .padding()
                    .background(.bar)
                    //endVStack
                }
                // end .safeAreaInset
            
        }
        //    endNavigationStack
    }
    //    endbody
    
    func deleteFriend(at offsets: IndexSet) {
        for index in offsets {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }
    }
    // end deleteFriend function
}
//end struct
    #Preview {
        ContentView()
            .modelContainer(for: Friend.self, inMemory: true)
        
    }

