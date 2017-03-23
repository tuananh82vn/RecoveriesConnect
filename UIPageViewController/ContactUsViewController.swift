//
//  ContactUsViewController.swift
//  UIPageViewController
//
//  Created by Anh Pham on 30/1/17.
//  Copyright © 2017 Vea Software. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originalAttributedText = self.txtView.attributedText?.mutableCopy() as! NSMutableAttributedString
        
        originalAttributedText.mutableString.replaceOccurrences(of: "1 300 663 060", with: LocalStore.accessClientPhoneInNo()!, options: .literal, range: NSMakeRange(0, originalAttributedText.string.length))
        
        self.txtView.attributedText = originalAttributedText
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
