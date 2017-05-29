

import UIKit

class UpdatePersonalInfoViewController: UIViewController , TKDataFormDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    let dataSource = TKDataFormEntityDataSource()
    
    var paymentInfo = PaymentInfo()
    
    var alignmentMode: String = ""
    
    var dataForm1  = TKDataForm()
    
    var validate1 : Bool = true
    
    var isError : Bool = false

    
    var paymentReturn = PaymentReturnModel()
    var screenComeForm: String = ""
    var paymentMethod = 0
    
    var CallbackSlot: [String] = ["", "Home Phone", "Work Phone" , "Mobile Phone"]
    var CallbackSlotValue: [String] = ["N", "H", "W" , "M"]

    
    @IBOutlet weak var bt_Continue: UIButton!
    
    var isFormValidate : Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpdatePersonalInfoViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //alignmentMode = "Top"
        
        if(self.screenComeForm == "CCPayment" || self.screenComeForm == "DDPayment"){

            self.navigationItem.setHidesBackButton(true, animated:true)

        }
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        loadData()
        
        self.dataForm1.reloadData()
        
        super.viewDidAppear(animated)
    }
    
    func loadData(){
        
        self.view.showLoading()
        
        WebApiService.GetPersonalInfo(){ objectReturn in
            
            self.view.hideLoading();
            
            if let temp1 = objectReturn
            {
                
                if(temp1.IsSuccess)
                {
                
                    self.paymentInfo = temp1
                    
                    self.dataSource.sourceObject = self.paymentInfo.personalInfo
                    
                    self.dataSource["StreetAddress1"].editorClass = TKDataFormTextFieldEditor.self
//                    self.dataSource["StreetAddress1"].editorClass = CustomTextFieldEditor.self
                    self.dataSource["StreetAddress1"].displayName = "Address 1"
                    
                    self.dataSource["Origin_StreetAddress1"].hidden = true
                    self.dataSource["Marked_StreetAddress1"].hidden = true
                    
                    self.dataSource["StreetAddress2"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["StreetAddress2"].displayName = "Address 2"

                    self.dataSource["Origin_StreetAddress2"].hidden = true
                    self.dataSource["Marked_StreetAddress2"].hidden = true
                    
                    self.dataSource["StreetAddress3"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["StreetAddress3"].displayName = "Address 3"

                    self.dataSource["Origin_StreetAddress3"].hidden = true
                    self.dataSource["Marked_StreetAddress3"].hidden = true
                
                    
                    self.dataSource["StreetSuburb"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["StreetSuburb"].displayName = "Suburb"
                    self.dataSource["Origin_StreetSuburb"].hidden = true
                    self.dataSource["Marked_StreetSuburb"].hidden = true
                    
                    self.dataSource["StreetPostCode"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["StreetPostCode"].displayName = "Postcode"
                    self.dataSource["Origin_StreetPostCode"].hidden = true
                    self.dataSource["Marked_StreetPostCode"].hidden = true
                    
                    self.dataSource["StreetState"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["StreetState"].displayName = "State"
                    self.dataSource["Origin_StreetState"].hidden = true
                    self.dataSource["Marked_StreetState"].hidden = true



                    self.dataSource["MailAddress1"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["MailAddress1"].displayName = "Address 1"
                

                    self.dataSource["Origin_MailAddress1"].hidden = true
                    self.dataSource["Marked_MailAddress1"].hidden = true
                    
                    self.dataSource["MailAddress2"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["MailAddress2"].displayName = "Address 2"

                    self.dataSource["Origin_MailAddress2"].hidden = true
                    self.dataSource["Marked_MailAddress2"].hidden = true
                    
                    self.dataSource["MailAddress3"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["MailAddress3"].displayName = "Address 3"

                    self.dataSource["Origin_MailAddress3"].hidden = true
                    self.dataSource["Marked_MailAddress3"].hidden = true
                
                    
                    self.dataSource["MailSuburb"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["MailSuburb"].displayName = "Suburb"
                    self.dataSource["Origin_MailSuburb"].hidden = true
                    self.dataSource["Marked_MailSuburb"].hidden = true
                    
                    self.dataSource["MailPostCode"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["MailPostCode"].displayName = "Postcode"
                    self.dataSource["Origin_MailPostCode"].hidden = true
                    self.dataSource["Marked_MailPostCode"].hidden = true
                    
                    self.dataSource["MailState"].editorClass = TKDataFormTextFieldEditor.self
                    self.dataSource["MailState"].displayName = "State"
                    self.dataSource["Origin_MailState"].hidden = true
                    self.dataSource["Marked_MailState"].hidden = true
                    
                    
                    self.dataSource["HomePhone"].editorClass = NormalPhoneEditor.self
                    self.dataSource["Origin_HomePhone"].hidden = true
                    self.dataSource["Marked_HomePhone"].hidden = true

                    self.dataSource["WorkPhone"].editorClass = NormalPhoneEditor.self
                    self.dataSource["Origin_WorkPhone"].hidden = true
                    self.dataSource["Marked_WorkPhone"].hidden = true

                    self.dataSource["MobilePhone"].editorClass = MyPhoneEditor.self
                    self.dataSource["Origin_MobilePhone"].hidden = true
                    self.dataSource["Marked_MobilePhone"].hidden = true

                    self.dataSource["Preferred"].valuesProvider = self.CallbackSlot
                    self.dataSource["Preferred"].editorClass = TKDataFormPickerViewEditor.self
                    
                    self.dataSource["EmailAddress"].editorClass = TKDataFormEmailEditor.self
                    self.dataSource["EmailAddress"].displayName = "Email"
                    self.dataSource["Origin_EmailAddress"].hidden = true
                    self.dataSource["Marked_EmailAddress"].hidden = true
                    
                    self.dataSource.addGroup(withName: "Street Address", propertyNames: [ "StreetAddress1","StreetAddress2","StreetAddress3","StreetSuburb","StreetPostCode","StreetState" ])

                    self.dataSource.addGroup(withName: "Mail Address", propertyNames: [ "MailAddress1","MailAddress2","MailAddress3","MailSuburb","MailPostCode","MailState" ])
                    
                    self.dataSource.addGroup(withName: "Phone & Email", propertyNames: [ "HomePhone","WorkPhone","MobilePhone","Preferred" ,"EmailAddress"])
                    
                    self.dataForm1.groupSpacing = 30
                    self.dataForm1 = TKDataForm(frame: self.subView.bounds)
                    
                    self.dataForm1.delegate = self
                    self.dataForm1.dataSource = self.dataSource
                    self.dataForm1.allowScroll = true
                    
                    self.dataForm1.backgroundColor = UIColor.white
                    self.dataForm1.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
                    
                    self.dataForm1.commitMode = TKDataFormCommitMode.manual
                    self.dataForm1.validationMode = TKDataFormValidationMode.immediate
                    
                    self.subView.addSubview(self.dataForm1)
                    
                }
                else
                {
                    LocalStore.Alert(self.view, title: "Error", message: temp1.Errors, indexPath: 0)
                    self.bt_Continue.setTitle("Finish", for: UIControlState())
                    self.isError = true

                }
 
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Server not found.", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func dataForm(_ dataForm: TKDataForm, update groupView: TKEntityPropertyGroupView, forGroupAt groupIndex: UInt) {
        groupView.titleView.titleLabel.textColor = UIColor.lightGray
        groupView.titleView.titleLabel.font = UIFont.systemFont(ofSize: 17)
        groupView.titleView.style.insets = UIEdgeInsetsMake(0, 10, 0, 0)
        if groupIndex == 0 {
            groupView.editorsContainer.backgroundColor = UIColor.lightGray
        }
        
        if groupIndex == 1 {
            groupView.editorsContainer.backgroundColor = UIColor.clear
        }
        
        if groupIndex == 2 {
            groupView.editorsContainer.backgroundColor = UIColor.lightGray
        }
    }
    
    func dataForm(_ dataForm: TKDataForm, update editor: TKDataFormEditor, for property: TKEntityProperty) {
        
        property.hintText = property.displayName
        
        
    }
    
    
    func setEditorStyle(_ editor: TKDataFormEditor) {
        
        var layer = editor.editor.layer
        
        if editor.isKind(of: TKDataFormTextFieldEditor.self) {
            layer = editor.editor.layer;
            (editor.editor as! TKTextField).textInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        
        if editor.isKind(of: TKDataFormPickerViewEditor.self){
        
        }
        else
        {
            layer.borderColor = UIColor(red:0.880, green:0.880, blue:0.880, alpha:1.00).cgColor
            layer.borderWidth = 1.0
            layer.cornerRadius = 4
        }
    }
    
    func dataForm(_ dataForm: TKDataForm, validate propery: TKEntityProperty, editor: TKDataFormEditor) -> Bool {
        if (propery.name == "MobilePhone") {
            
            let value = propery.valueCandidate as! NSString
            
            if (value.length <= 0)
            {
                dataSource["MobilePhone"].errorMessage = "Please enter 'Mobile Phone'"
                self.validate1 = false
                return self.validate1
            }
            
            self.validate1 = true


        }

        return true
    }
    
    
    func dataForm(_ dataForm: TKDataForm, heightForHeaderInGroup groupIndex: UInt) -> CGFloat {
        return 40
    }
    
    func CompareText(displayText : String, markText: String, originText: String) -> String {
        if(displayText == markText){
            return originText
        }
        else
        {
            return displayText
        }
    }
    
    @IBAction func btContinue_Clicked(_ sender: AnyObject) {
        
        
        if(!self.isError)
        {
            self.dataForm1.commit()
            
            
            self.isFormValidate = self.validate1 //&& self.validate2 && self.validate3 && self.validate4 && self.validate5
            
            if(!self.isFormValidate){
                
                return
            }
            
            
            self.view.showLoading();
            
            let personalInfo = PersonalInfo()
            
            personalInfo.StreetAddress1         = self.CompareText(displayText: self.dataSource["StreetAddress1"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_StreetAddress1,originText: self.paymentInfo.personalInfo.Origin_StreetAddress1)

            personalInfo.StreetAddress2         = self.CompareText(displayText: self.dataSource["StreetAddress2"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_StreetAddress2,originText: self.paymentInfo.personalInfo.Origin_StreetAddress2)
            
            personalInfo.StreetAddress3         = self.CompareText(displayText: self.dataSource["StreetAddress3"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_StreetAddress3,originText: self.paymentInfo.personalInfo.Origin_StreetAddress3)
            
            
            personalInfo.StreetState        = self.CompareText(displayText: self.dataSource["StreetState"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_StreetState,originText: self.paymentInfo.personalInfo.Origin_StreetState)
            
            personalInfo.StreetSuburb        = self.CompareText(displayText: self.dataSource["StreetSuburb"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_StreetSuburb,originText: self.paymentInfo.personalInfo.Origin_StreetSuburb)

            personalInfo.StreetPostCode        = self.CompareText(displayText: self.dataSource["StreetPostCode"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_StreetPostCode,originText: self.paymentInfo.personalInfo.Origin_StreetPostCode)
            
            
            personalInfo.MailAddress1         = self.CompareText(displayText: self.dataSource["MailAddress1"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_MailAddress1,originText: self.paymentInfo.personalInfo.Origin_MailAddress1)
            
            personalInfo.MailAddress2         = self.CompareText(displayText: self.dataSource["MailAddress2"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_MailAddress2,originText: self.paymentInfo.personalInfo.Origin_MailAddress2)
            
            personalInfo.MailAddress3         = self.CompareText(displayText: self.dataSource["MailAddress3"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_MailAddress3,originText: self.paymentInfo.personalInfo.Origin_MailAddress3)
            
            
            personalInfo.MailState        = self.CompareText(displayText: self.dataSource["MailState"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_MailState,originText: self.paymentInfo.personalInfo.Origin_MailState)
            
            personalInfo.MailSuburb        = self.CompareText(displayText: self.dataSource["MailSuburb"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_MailSuburb,originText: self.paymentInfo.personalInfo.Origin_MailSuburb)
            
            personalInfo.MailPostCode        = self.CompareText(displayText: self.dataSource["MailPostCode"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_MailPostCode,originText: self.paymentInfo.personalInfo.Origin_MailPostCode)
            
            personalInfo.HomePhone        = self.CompareText(displayText: self.dataSource["HomePhone"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_HomePhone,originText: self.paymentInfo.personalInfo.Origin_HomePhone)
            
            personalInfo.MobilePhone        = self.CompareText(displayText: self.dataSource["MobilePhone"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_MobilePhone,originText: self.paymentInfo.personalInfo.Origin_MobilePhone)
         
            personalInfo.WorkPhone        = self.CompareText(displayText: self.dataSource["WorkPhone"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_WorkPhone,originText: self.paymentInfo.personalInfo.Origin_WorkPhone)
            
            personalInfo.EmailAddress        = self.CompareText(displayText: self.dataSource["EmailAddress"].valueCandidate as! String,markText: self.paymentInfo.personalInfo.Marked_EmailAddress,originText: self.paymentInfo.personalInfo.Origin_EmailAddress)
            
            personalInfo.Preferred              = self.dataSource["Preferred"].valueCandidate as! Int


            WebApiService.SetPersonalInfo(personalInfo){ objectReturn in
                
                self.view.hideLoading();
                
                if let temp1 = objectReturn
                {
                    
                    if(temp1.IsSuccess)
                    {
                        WebApiService.sendActivityTracking("Update Personal Info")
                        if(self.screenComeForm == "CCPayment" || self.screenComeForm == "DDPayment"){
                            self.performSegue(withIdentifier: "GoToSummary", sender: nil)
                        }
                        else
                        {
                            self.performSegue(withIdentifier: "GoToNotice", sender: nil)
                        }
                    }
                    else
                    {
                        
                        LocalStore.Alert(self.view, title: "Error", message: temp1.Errors, indexPath: 0)
                        
                    }
                }
                else
                {
                    
                    LocalStore.Alert(self.view, title: "Error", message: "Server not found.", indexPath: 0)
                    
                }
            }
        }
        else
        {
            
            navigationController?.popViewController(animated: true)
            
        }
        
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToNotice" {
            
            let controller = segue.destination as! FinishViewController
            controller.message = "Your personal information has been updated successfully"
            
        }
        
        if segue.identifier == "GoToSummary" {
            
            let controller = segue.destination as! SummaryViewController
            controller.paymentReturn = self.paymentReturn
            controller.paymentMethod = self.paymentMethod
        }
    }

    
}
