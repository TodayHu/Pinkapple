//
//  InterfaceController.swift
//  Pinkapple WatchKit Extension
//
//  Created by yuye wang on 3/23/15.
//  Copyright (c) 2015 yuye wang. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var shotImage: WKInterfaceImage!
    
    var shots :[Shot]!
    var index : Int!
    
    //var cellHeight : CGFloat = 240
    @IBAction func nextButtonPressed() {
        self.index = self.index + 1
        if ( self.index >= shots.count ){
            self.index = 0
        }
        self.loadImage()
    }
    
    func loadImage(){
        println("index: \(self.index) count: \(shots.count)")
        var shot = self.shots[self.index]
        asyncLoadShotImage(shot, interfaceImage: self.shotImage)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.shots = [Shot]()
        self.index = 0
        let api = DribbbleAPI()
        api.loadShots(didLoadShots)
       
    }
    
    func didLoadShots(shots: [Shot]){
        self.shots = shots
        //shots 是list of shots we got
        //collectionView.reloadData()
        self.loadImage()
        
    }
    
    func asyncLoadShotImage(shot: Shot, interfaceImage : WKInterfaceImage){
        
        let downloadQueue = dispatch_queue_create("com.wangyuye.processdownload", nil)
        
        dispatch_async(downloadQueue){
            var data = NSData(contentsOfURL: NSURL(string: shot.imageUrl)!)
            var image : UIImage?
            if data != nil {
                shot.imageData = data
                image = UIImage(data: data!)!
            }
            
            dispatch_async(dispatch_get_main_queue()){
                interfaceImage.setImage(image)
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
