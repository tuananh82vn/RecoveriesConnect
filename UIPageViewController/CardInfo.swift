//
//  CardInfo.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//



import UIKit

class CardInfo: NSObject {

    var Amount = Float32()
    var PaymentMethod = 0
    var CardType = 0
    var NameOnCard = ""
    var CardNumber = ""
    var ExpiryMonth = 0
    var ExpiryYear  = 0
    var Cvv = ""
    
    
    var AccountName = ""
    var BSB = ""
    var AccountNumber = ""

    var DebtorPaymentInstallment = ""
    var ExpiryDate  = ""

}

class CardInfo2: NSObject {
    
    var Amount = Double()
    var PaymentMethod = 0
    var CardType = 0
    var NameOnCard = ""
    var CardNumber = ""
        
}

class UpdateCardInfo: NSObject {
    
    var CardNumber = ""
    var ExpiryMonth = 0
    var ExpiryYear  = 0
}




