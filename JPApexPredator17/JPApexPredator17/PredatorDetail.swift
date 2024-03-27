//
//  PredatorDetail.swift
//  JPApexPredator17
//
//  Created by Kushank Virdi on 2024-03-06.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    
    @State var position:MapCameraPosition
    var body: some View {
        GeometryReader{ geo in
            
        
            ScrollView{
                ZStack(alignment:.bottomTrailing){
                    //Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: 
                                            [Gradient.Stop(color: .clear, location: 0.8),
                                             Gradient.Stop(color: .black, location: 1)
                            
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    //Dino Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x:-1)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 7)
                        .offset(y:20)
                    
                }
                
                //Dino Name
                VStack(alignment:.leading){
                    Text(predator.name)
                        .font(.largeTitle)
                
                
                
                
                
                //Current Location
                    NavigationLink{
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000,
                                                                heading: 250,
                                                                pitch: 80)))
                    }label: {
                        
                        Map(position:$position){
                            
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        
                        .overlay(alignment:.trailing){
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment:.topLeading){
                            Text("Current Location")
                                .padding([.leading,.bottom],5)
                                .padding(.trailing,8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                        
                    }
                
                //Appears in
                Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    ForEach(predator.movies, id: \.self){movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                
                //Movie Moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top,15)
                    ForEach(predator.movieScenes){scene in
                        
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                        
                    }
                
                //Link to webpage
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string : predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                        .padding(.bottom, 10)
                
            }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)
        }
        .ignoresSafeArea()
    }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack{
        PredatorDetail(predator: Predators().apexPredators[10], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[10].location, distance: 30000)))
        //        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}