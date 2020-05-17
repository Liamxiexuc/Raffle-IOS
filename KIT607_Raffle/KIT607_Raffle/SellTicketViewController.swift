//
//  SellTicketViewController.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 10/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class SellTicketViewController: UIViewController {
    var raffle : Raffle?
    var customer : Customer?
    var raffleselling : Raffle?
    

   var raffleID = 1
    var raffleName = ""
    var ticketPrice = 1
    var customerID = 1
    var customerName = ""
    var purchaseDate = ""
    var winStatus = 0
    var ticketNumber = 1
   
    var numberOfTicket = 1

    var displayDrawType=""
    @IBOutlet weak var raffleNameLable: UILabel!
    
    @IBOutlet weak var raffleDes: UILabel!
    @IBOutlet weak var rafflePrice: UILabel!
    @IBOutlet weak var drawType: UILabel!
    @IBOutlet weak var ticketQty: UILabel!
    @IBOutlet weak var drawDate: UILabel!
    
    @IBOutlet weak var customerNameTextField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let  displayCustomer = customer
        {
            customerNameTextField.text = displayCustomer.customerName 
           
        }
        if let displayRaffle = raffleselling{
            
            if(displayRaffle.type == 0){
                displayDrawType = "Normal Raffle"

            } else {
                displayDrawType = "Marging Raffle"
            }
            raffleNameLable.text = displayRaffle.name
            raffleDes.text = displayRaffle.description
            rafflePrice.text = String(displayRaffle.ticketPrice)
            drawType.text = displayDrawType
            drawDate.text = displayRaffle.drawTime
            
        }
    }
    
    @IBAction func createNewTicket(_ sender: UIButton) {
        raffleID = Int(raffleselling!.ID)
        raffleName = raffleselling!.name
        ticketPrice = Int(raffleselling!.ticketPrice)
        customerID = Int(customer!.ID)
        customerName = customer!.customerName
        let dateformatter = DateFormatter() //因为数据库存的购买日类型是string
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        purchaseDate = dateformatter.string(from: Date()) //TODO 取当前时间 Fixed
        print(purchaseDate)
        ticketNumber = 1
        if (raffleselling?.type == 0) {
            //TODO
            //数据库取最大值，再加一
            // ticketNumber = Max(existTicketNumber) + 1
        } else {
            //if 查询raffle.ticketnumber是否为空,
            
            //  gen random num (1, 100);  49;
            //  存数据库 ticket= random num;
            // elif buweikong不为空
            // 数据库取存在的ticket number值 []数组；
            //
            //var arr[] = raffle.maxlength;  [1~ 50]
            // new[] = arr[] - exist[];
            //new[] 里随机取一个数;
            //new[] 长度 random index;
            // 存数据库 ticket= random num;
        }
        
        
        
        
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
       database.insert(ticket: Ticket(raffleID:Int32(raffleID),  raffleName:raffleName, ticketPrice:Int32(ticketPrice),customerID:Int32(customerID), customerName: customerName, purchaseDate: purchaseDate, winStatus: Int32(winStatus), ticketNumber: Int32(ticketNumber)))
        
//        database.insert(ticket: Ticket(raffleID:3,  raffleName:"raffle6666", ticketPrice:0,customerID:30, customerName: "hello", purchaseDate: "89/987/99", winStatus:0, ticketNumber: 1003))
             
       
        let refreshAlert=UIAlertController(title: "TicketCreated", message: "", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                 self.performSegue(withIdentifier: "GoTicketList", sender: self)
                 }))
        present(refreshAlert, animated: true, completion: nil)
        
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        ticketQty.text = String(format: "%.0f", sender.value)
        numberOfTicket = Int(sender.value)
    }
    
    @IBAction func addCustomerInfor(_ sender: UIButton) {
        performSegue(withIdentifier: "FindCustomer", sender: self)
    }
    
    override func   prepare(for segue: UIStoryboardSegue, sender: Any?)
       {
           super.prepare(for: segue, sender: sender)
           if segue.identifier == "FindCustomer"
           {
                let detailViewController = segue.destination as! CustomerCusTableViewController
                let selectedRaffle = raffleselling
            detailViewController.raffleTemp = selectedRaffle
           }
           else if segue.identifier == "GoTicketList"
           {
                let ticketListViewController = segue.destination as! TicketCusTableViewController
            ticketListViewController.raffleID = raffleID
           }
            else
           {
               fatalError("Unexpected destination: \(segue.destination)")
           }
           
           }
 

}
