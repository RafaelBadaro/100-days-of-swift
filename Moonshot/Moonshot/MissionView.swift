//
//  MissionView.swift
//  Moonshot
//
//  Created by Rafael Badaró on 26/02/25.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                MissionImage(image: mission.image,
                             launchDate: mission.launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
                
                DividerView()
                
                MissionDescription(description: mission.description)
                    .padding(.horizontal)
                
                DividerView()
                
                CrewScrollView(crew: crew)
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

struct MissionImage: View {
    var image: String
    var launchDate: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { width, axis in
                    width * 0.6
                }
            
            if !launchDate.isEmpty {
                Text(launchDate)
                    .padding(.top, 20)
            }
        }
    }
}

struct MissionDescription: View {
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mission Highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            Text(description)
        
        }
    }
}

struct CrewScrollView: View {
    var crew: [CrewMember]
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
                        CrewMemberView(crewMember: crewMember)
                    }
                }
            }
        }
    }
}

struct CrewMemberView: View {
    var crewMember: CrewMember
    
    var body: some View {
        NavigationLink {
            AstronautView(astronaut: crewMember.astronaut)
        } label: {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(.capsule)
                    .overlay(
                        Capsule()
                            .strokeBorder(.white, lineWidth: 1)
                    )
                
                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    Text(crewMember.role)
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
        }
    }
}

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding()
    }
}
