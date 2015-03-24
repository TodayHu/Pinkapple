//
//  FaceTwoController.swift
//  Pinkapple
//
//  Created by yuye wang on 3/23/15.
//  Copyright (c) 2015 yuye wang. All rights reserved.
//

import WatchKit
import Foundation


class FaceTwoController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    var shots :[Shot]!

    
    //var cellHeight : CGFloat = 240
    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.shots = [Shot]()
  
        let api = DribbbleAPI()
        api.loadShots(didLoadShots2)
        
       
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("ZoomEmojiController", context: nil)
    }
    
    
    func didLoadShots2(shots: [Shot]){
        self.shots = shots
        self.table.setNumberOfRows(self.shots.count, withRowType: "ShotRow")
        
        for i in 0..<shots.count {
            var theRow = self.table.rowControllerAtIndex(i) as ShotRow
            var shot = self.shots[i]
            asyncLoadShotImage2(shot, interfaceImage: theRow.shotRowImage)
        }
        
    }

    
    func asyncLoadShotImage2(shot: Shot, interfaceImage : WKInterfaceImage){
        
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
    
}