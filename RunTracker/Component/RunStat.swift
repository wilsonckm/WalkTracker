//
//  RunStat.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/5/24.
//

import SwiftUI

struct RunStat: View {
    var name: String = ""
    var value: String = ""
    var units: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text(value)
                    .bold()
                    .font(.system(size: 24))
                Text(units)
                    .bold()
                    .font(.system(size: 20))
                    .padding(.horizontal, -5 )
                Spacer()
            }
            HStack {
                Text(name)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                Spacer()
            }
        }
    }
}

#Preview {
    RunStat( name: "Distance", value: "2.32", units: "mi")
}
