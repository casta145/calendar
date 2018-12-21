//
//  CalendarVar.swift
//  calendar
//
//  Created by Alfonso Castanos on 12/20/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date) - 1
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)
