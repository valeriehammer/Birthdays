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
    
    var body: some View {
        NavigationStack {
            List(friends) { Friend in
                HStack{
                    Text(Friend.name)
                    Spacer()
                    Text(Friend.birthday, format: .dateTime.month(.wide).day().year())
                }
                //  end HStack
            }
            // endList
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack{
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save"){
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = Date.now
                        
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
            //
        }
        //    endNavigationStack
    }
    //    endbody
}
//end struct
    #Preview {
        ContentView()
            .modelContainer(for: Friend.self, inMemory: true)
        
    }

