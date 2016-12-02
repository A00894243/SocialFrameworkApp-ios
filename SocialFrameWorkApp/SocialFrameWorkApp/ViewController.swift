//
//  ViewController.swift
//  SocialFrameWorkApp
//
//  Created by Spencer Joel on 2016-12-01.
//  Copyright © 2016 Spencer Joel. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNoteTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showShareOptions(_ sender: Any) {
        if self.isFirstResponder {
            self.resignFirstResponder()
        }
        let actionSheet = UIAlertController(title: "", message: "Share your Note", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let tweetAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                if (self.myTextView.text.characters.count <= 140) {
                    twitterComposeVC?.setInitialText(self.myTextView.text)
                    self.present(twitterComposeVC!, animated: true, completion: nil)
                }
                else {
                    let str = self.myTextView.text
                    let index = str?.index((str?.startIndex)!, offsetBy: 140)
                    
                    
                    let subText = str?.substring(to: index!)
                    twitterComposeVC?.setInitialText("\(subText)")
                }
            }
            else {
                self.showAlertMessage(message: "You are not logged in to your Twitter account.")
            }
            
        }
        
        
        // Configure a new action to share on Facebook.
        let facebookPostAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.default) { (action) -> Void in
            
        }
        
        // Configure a new action to show the UIActivityViewController
        let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.default) { (action) -> Void in
            let activityViewController = UIActivityViewController(activityItems: [self.myTextView.text], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        
        
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (action) -> Void in
            
        }
        
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        
        present(actionSheet, animated: true, completion: nil)
    
    }
    
    func configureNoteTextView() {
        myTextView.layer.cornerRadius = 8.0
        myTextView.layer.borderColor = UIColor(white: 0.75, alpha: 0.5).cgColor
        myTextView.layer.borderWidth = 1.2
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

