//
//  TenDaysForecastView.swift
//  WeatherApp
//
//  Created by Darot on 26/04/2022.
//
import Core
import SwiftUI

struct TenDaysForecastView: View {
    @EnvironmentObject private var wvm: WeatherForecastViewModel
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            HStack{
                Image(systemName: "calendar")
                    .foregroundColor(Color.white)
                Text("10-Day Forecast")
                    .foregroundColor(Color.white)
            }.padding()
            if let forecast = wvm.forecast.forecast {
                ForEach(forecast.forecastday, id: \.hour.first?.timeEpoch){ forecastday in
                    let forecastdate = Date(timeIntervalSince1970: TimeInterval(forecastday.dateEpoch))
                    let dayOfTheWeekName = convertTimeIntervalToWeekdayName(epochTime: forecastdate)
                    ForecastItem(dayOfTheWeek: dayOfTheWeekName, imageUrl: forecastday.day!.condition!.icon, temp: "\(forecastday.day!.avgtempC)")
                         .listRowBackground(Color.clear)
                }.padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.black)
        .opacity(0.5)
        .cornerRadius(10)
        .padding()
        .handleViewState(uiModel: $wvm.uiModel)
        
    }
}

struct TenDaysForecastView_Previews: PreviewProvider {
    static var previews: some View {
        TenDaysForecastView()
    }
}
