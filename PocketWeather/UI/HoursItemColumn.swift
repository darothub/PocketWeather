//
//  HoursItemColumn.swift
//  WeatherApp
//
//  Created by Darot on 26/04/2022.
//

import SwiftUI

struct HoursItemColumn: View {
    static var tempTextSize = 16.0
    @State var dayNum = "0"
    @State var temp = "14"
    @State var imageUrl = "//cdn.weatherapi.com/weather/64x64/day/176.png"
    var body: some View {
        VStack(spacing:20){
            Text(dayNum)
            AsyncImage(url: URL(string: "https:"+imageUrl)) { image in
                image.resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .scaledToFill()
            } placeholder: {
                Image("cloud")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .scaledToFill()
            }
            Text(temp)
                .font(.system(size: HoursItemColumn.tempTextSize))
            + Text("O")
                .font(.system(size: 8.0))
                .baselineOffset(HoursItemColumn.tempTextSize/2)
            
        }
    }
}

struct HoursItemColumn_Previews: PreviewProvider {
    static var previews: some View {
        HoursItemColumn()
    }
}
