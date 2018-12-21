//
//  CalendarViewController.swift
//  calendar
//
//  Created by Alfonso Castanos on 12/20/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

var dateString = ""
var savedDates : [String] = ["24 December 2018", "25 December 2018", "31 December 2018", "1 Janurary 2019"]
var savedEvent : [String] = ["Christmas Eve", "Christmas", "New Years Eve", "New Years"]
var myindex = 0

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    //setting the months into a list to be accessed
    let Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September","October", "November", "December"]
    
    //setting the days of the week into a list to be accessed
    let DaysOfMonth = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    //setting the number of days in each month into a list
    var DaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    //stting all the variables needed to help run calendar program
    var currentMonth = String()
    var NumberOfEmptyBox = Int() //Number of Empty Boxes at the start of the current month
    var NextNumberOfEmptyBox = Int() //Number of Empty Boxes at the start of the next month
    var PreviousNumberOfEmptyBox = 0 //Number of Empty Boxes of the previous month
    var Direction = 0 //=0 current month; =1 next month; =-1 previous month
    var PositionIndex = 0 //store the above vars of the empty boxes
    var LeapYearCt = 2 //next time feb has 29 days is in two years (happens every 4 years)
    var dayCt = 0
    var highlightdate = -1
    var cellsArray: [UICollectionViewCell]  = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        if weekday == 0 {
            weekday = 7
        }
        GetStartDayDatePosition()
        
        
    }
    
    //function that allows to move to the next correct month when clicking the next arrow key above the calendar
    @IBAction func Next(_ sender: UIButton) {
        highlightdate = -1
        switch currentMonth {
        case "December":
            Direction = 1
            month = 0
            year += 1
            if LeapYearCt < 5 {
                LeapYearCt += 1
            }
            if LeapYearCt == 4 {
                DaysInMonth[1] = 29
            }
            if LeapYearCt == 5 {
                LeapYearCt = 1
                DaysInMonth[1] = 28
            }
            GetStartDayDatePosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationNext(Label: MonthLabel)
            Calendar.reloadData()
        default:
            Direction = 1
            GetStartDayDatePosition()
            month += 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationNext(Label: MonthLabel)
            Calendar.reloadData()
        }
    }
    
    //function allows to move to the correct month that comes before the month user is currently on
    @IBAction func Back(_ sender: UIButton) {
        highlightdate = -1
        switch currentMonth {
        case "January":
            Direction = -1
            month = 11
            year -= 1
            if LeapYearCt > 0 {
                LeapYearCt -= 1
            }
            if LeapYearCt == 0 {
                DaysInMonth[1] = 29
                LeapYearCt = 4
            } else {
                DaysInMonth[1] = 28
            }
            GetStartDayDatePosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationBack(Label: MonthLabel)
            Calendar.reloadData()
        default:
            Direction = -1
            month -= 1
            GetStartDayDatePosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationBack(Label: MonthLabel)
            Calendar.reloadData()
        }
    }
    
    //allows user to exit to the welcoming screen
    @IBAction func exit(_ sender: UIButton) {
        performSegue(withIdentifier: "segueSix", sender: self)
    }
    
    
    func GetStartDayDatePosition(){ //Function gives us the number of empty boxes
        switch Direction{
        case 0: //if we are at the current month
            NumberOfEmptyBox = weekday
            dayCt = day
            while dayCt > 0 {
                NumberOfEmptyBox = NumberOfEmptyBox - 1
                dayCt = dayCt - 1
                if NumberOfEmptyBox == 0 {
                    NumberOfEmptyBox = 7
                }
            }
            if NumberOfEmptyBox == 7 {
                NumberOfEmptyBox = 0
            }
            PositionIndex = NumberOfEmptyBox
        case 1...: //if we are at the next month
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonth[month]) % 7
            PositionIndex = NextNumberOfEmptyBox
        case -1: //if we are in the previous month
            PreviousNumberOfEmptyBox = (7 - (DaysInMonth[month] - PositionIndex) % 7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    //function below set up the dates in the correct cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction{ //returns number of days in the month and its empty boxes
        case 0:
            return DaysInMonth[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonth[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonth[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        
        cell.Circle.isHidden = true
        
        if cell.isHidden{
            cell.isHidden = false
        }
        
        switch Direction{
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1 { //Hides every cell that comes back negative
            cell.isHidden = true
        }
        
        //Showing weekend days in different colors
        switch indexPath.row { //Indexes of the collectionview that matches with the weekend days in every month
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.gray
            }
        default:
            break
        }
        
        //Marks the cell showing the current day in cyan
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 - NumberOfEmptyBox == day {
            
            cell.Circle.isHidden = false
            cell.DrawCricle()
        }
        
        if highlightdate == indexPath.row {
            cell.backgroundColor = UIColor(displayP3Red: 0.45, green: 0.67, blue: 0.27, alpha: 1.0)
        }
        
        cellsArray.append(cell)
        return cell
    }
    
    //when clicking a date it gathers the date and moves to new screen to create an event
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dateString = "\(indexPath.row - PositionIndex + 1) \(currentMonth) \(year)"
        
        performSegue(withIdentifier: "NextView", sender: self)
        
        highlightdate = indexPath.row
        //savedDates.append(dateString)
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        for x in cellsArray {
            let cell : UICollectionViewCell = x
            UIView.animate(withDuration: 1, delay: 0.01 * Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        }
    }
    
    //functions below allow for the creation of the events scroll box that has a list of all the events you have created
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventsTableViewCell
        
        tableCell?.EventDate.text = savedDates[indexPath.row]
        tableCell?.cellDelgate = self as? TableViewNew
        tableCell?.index = indexPath
        
        return tableCell!
    }
    
    func onClickCell(index: Int) {
        print(index)
        performSegue(withIdentifier: "segueFour", sender: self)
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        //need to fix. this does not go to next view
//        myindex = indexPath.row
//        performSegue(withIdentifier: "segueFour", sender: self)
//    }
}

//extension ViewController: TableViewNew {
//    func onClickCell(index: Int) {
//        performSegue(withIdentifier: "segueFour", sender: self)
//    }
//}
