//
//  ForecastItem.swift
//  WeatherApp
//
//  Created by Darot on 26/04/2022.
//

import SwiftUI

struct ForecastItem: View {
    @State var dayOfTheWeek:String = "Today"
    @State var imageUrl = "//cdn.weatherapi.com/weather/64x64/day/176.png"
    @State var temp = "14"
    var body: some View {
        VStack{
            Divider()
                .background(.white)
            HStack {
                Text(dayOfTheWeek)
                    .font(.body)
                AsyncImage(url: URL(string:"https:"+imageUrl)) { image in
                    image.resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .scaledToFill()
                } placeholder: {
                    Image("cloud")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .scaledToFill()
                }
                Spacer()
                Text(temp)
                    .font(.system(size: HoursItemColumn.tempTextSize))
                + Text("O")
                    .font(.system(size: 8.0))
                    .baselineOffset(HoursItemColumn.tempTextSize/2)
            }
        }
    }
}

struct ForecastItem_Previews: PreviewProvider {
    static var previews: some View {
        ForecastItem()
    }
}
