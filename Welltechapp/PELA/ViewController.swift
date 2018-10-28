//
//  ViewController.swift
//  Welltech
//
//  Created by Simon Liao on 2018/10/28.
//  Copyright © 2018年 Simon Liao. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var temLab: UILabel!
    
    @IBOutlet weak var goodImage: UIImageView!
    
    @IBOutlet weak var timerLab: UILabel!
    
    @IBOutlet weak var gifImage: UIImageView!
    
    func getJSON() {
        
        let url = "https://api.thingspeak.com/channels/147306/fields/2.json"
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    //print("JSON: \(json)")
                    
                    //取得temp值
                    let feeds = json["feeds"][99]["field2"].doubleValue
                    print (feeds)
                    
                    //轉型
                    let tempData = String(format: "%.1f", feeds)
                    
                    //傳回Label
                    self.temLab.text = tempData
                    /*
                     //取得所有值
                     
                     for (key, subJson): (String, JSON) in json["feeds"] {
                     print(key)
                     if let field1 = subJson["field1"].string {
                     print(field1)
                     }
                     }
                     */
                    //計時器
                    var timer = NSTimer()
                    
                    var count = 0
                    
                    func updateTime() {
                        
                        count += 1
                        
                        self.timerLab.text = "\(count)"
                        
                    }
                    
                    let distance = feeds
                    
                    if distance <= 30 {
                        
                        //隱藏開心圖，顯示疲勞圖
                        self.goodImage.hidden = true
                        
                        //警告圖示
                        let loginFailWarnAlertController = UIAlertController(title: "警告", message: "距離螢幕太近！", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let okAlertAction = UIAlertAction(title: "矯正姿勢", style: UIAlertActionStyle.Default, handler: nil)
                        loginFailWarnAlertController.addAction(okAlertAction)
                        
                        self.presentViewController(loginFailWarnAlertController, animated: true, completion: nil)
                        
                        //震動提示
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                        
                        //播放聲音
                        AudioServicesPlaySystemSound(1005)
                        
                        /*
                        //時間計時開始
                        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
 */
                        
                    }
                    else {
                        
                        //取消隱藏開心圖
                        self.goodImage.hidden = false
                        
                        //時間計時停止
                        timer.invalidate()
                        
                        count = 00
                        
                        self.timerLab.text = "30"
                        
                    }
                    
                    if distance <= 0 {
                        
                        self.temLab.text = "Stay back!"
                        
                    }
                    
                }
            case .Failure(let error):
                print(error)
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.getJSON), userInfo: nil, repeats: true)
        
        // 設定起始頁時間
        NSThread.sleepForTimeInterval(1)
        
        //輸入gif
        //let Gif = UIImage.gif(name: "eye_cut")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

