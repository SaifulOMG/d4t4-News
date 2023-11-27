//
//  SearchBar.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import SwiftUI
//Custom Search bar
struct SearchBar: View {
    @Binding var searchText: String
    @FocusState var isFocused: Bool //dismiss keyboard
    @Binding var fromDate: Date
    @Binding var toDate: Date
    @State private var showingDatePicker = false
    var action: () -> ()
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                TextField("", text: $searchText)
                    .padding(10)
                    .background(Color.white)
                    .foregroundStyle(.black)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.leading)
                    .overlay(
                        HStack {
                            Spacer()
                            if !searchText.isEmpty {
                                Button(action: clearSearchText) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    )
                    .focused($isFocused)
                
                if searchText.isEmpty {
                    Text("Search...") //Custom Placeholder text
                        .padding(.leading, 25)
                        .foregroundStyle(Color(red: 0.8, green: 0.8, blue: 0.78))
                }
            }
            // Calendar Button
             Button(action: {
                 showingDatePicker = true
             }) {
                 Image(systemName: "calendar")
                     .foregroundColor(.white)
                     .padding(.vertical, 8)
                     .padding(.horizontal, 16)
                     .frame(height: 42)
                     .background(Color.indigo)
                     .cornerRadius(5)
            }
            
            Button(action: {
                action()
                isFocused = false
            }) {
                Text("Find")
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .frame(height: 42)
                    .background(Color.indigo)
                    .cornerRadius(5)
            }
            .padding(.trailing)
        }.sheet(isPresented: $showingDatePicker) {
            // Date Picker View
            ZStack {
                Color.white
                
                VStack {
                    Text("News Date Selection")
                        .foregroundStyle(.black)
                        .font(.system(size: 24))
                        .padding()
                    
                    Spacer()
                    
                    HStack {
                        Text("From:")
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        DatePicker("", selection: $fromDate, displayedComponents: .date)
                            .labelsHidden()
                            .onChange(of: fromDate) {
                                if toDate < fromDate {
                                    toDate = fromDate
                                }
                            }
                    }

                    HStack {
                        Text("To:")
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        DatePicker("", selection: $toDate, in: fromDate..., displayedComponents: .date)
                            .labelsHidden()
                    }
                    Button(action: {
                        showingDatePicker = false
                    }) {
                        Text("Done")
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .frame(height: 42)
                            .background(Color.blue)
                            .cornerRadius(5)
                    }
                    .padding()
                    
                    Spacer()
                    
                }.padding()
            }
        }
    }
    
    private func clearSearchText() {
        searchText = ""
    }
}

#Preview {
    SearchBar(searchText: .constant(""),fromDate: .constant(Date()), toDate: .constant(Date()), action: {})
}
