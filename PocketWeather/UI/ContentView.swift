//
//  ContentView.swift
//  WeatherApp
//
//  Created by Darot on 26/04/2022.
//

import Combine
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: WeatherForecastViewModel
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                CurrentWeatherInfoViews()
                HourlyForecastView()
                TenDaysForecastView()
//                Text("\((content.data).current.tempC)")
            }.environmentObject(vm)
        }
    }


}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Dependencies.createWFVM())
    }
}
