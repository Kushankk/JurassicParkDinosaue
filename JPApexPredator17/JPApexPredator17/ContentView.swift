//
//  ContentView.swift
//  JPApexPredator17
//
//  Created by Kushank Virdi on 2024-02-25.
//

import SwiftUI
import MapKit

struct ContentView: View {
   let predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PredatorType.all
    
    //This is a computed property
    var filteredDinos: [ApexPredator]{
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
       return predators.search(for: searchText)
        
    }
    var body: some View {
        NavigationStack{
            List(filteredDinos){ predator in
                NavigationLink{
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                    
                    
                }label:{
                    HStack{
                        //Dino Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color:predator.type.background ,radius: 2)
                        
                        
                        VStack(alignment: .leading){
                            //Dino Name
                            Text(predator.name)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            
                            //Dino Type
                            Text(predator.type.rawValue.capitalized)
                                .fontWeight(.semibold)
                                .font(.subheadline)
                                .padding(.horizontal,13)
                                .padding(.vertical,5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                            
                            
                        }
                    }
                }
                
            }
            .searchable(text: $searchText)
            .navigationTitle("Apex Predators")
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        withAnimation{
                            alphabetical.toggle()                        }
                        
                        
                    }label: {
                        
                        Image(systemName: alphabetical ? "film": "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                        
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        
                        Picker("selector", selection: $currentSelection.animation()){
                            ForEach(PredatorType.allCases){
                                type in
                                Label(type.rawValue, systemImage: type.icon)
                            }
                        }
                        
                    }label:{
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
                

        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        
    }
}

#Preview {
    ContentView()
}
