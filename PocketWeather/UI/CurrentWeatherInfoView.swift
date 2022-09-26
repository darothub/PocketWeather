//
//  CurrentWeatherSummaryView.swift
//  WeatherApp
//
//  Created by Darot on 27/04/2022.
//
import Combine
import SwiftUI

struct CurrentWeatherInfoViews: View {
    @EnvironmentObject private var wvm: WeatherForecastViewModel
    var body: some View {
        VStack{
            Text(wvm.forecast.location?.name ?? "None")
                .font(.title)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
            if let temp:Double = wvm.forecast.current?.tempC {
                Text(String(format: "%.1f", temp as CVarArg))
                    .font(.system(size: 100))
                + Text("O")
                    .font(.title)
                    .baselineOffset(100/2)
            }
            Text(wvm.forecast.current?.condition?.text ?? "None")
                .font(.title2)
        }.handleViewState(uiModel: $wvm.uiModel)
       
    }
    
}

struct CurrentWeatherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherInfoViews()
            .environmentObject(Dependencies.createWFVM())
    }
}
