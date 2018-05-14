//
//  ViewController.swift
//  Graffiti
//
//  Created by jjc on 2018/5/3.
//  Copyright © 2018年 jjc. All rights reserved.
//
//background.jpg 24  width 31*24 height 38*24  38/31  
import UIKit
let WINDOW_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
let WINDOW_WIDTH:CGFloat = UIScreen.main.bounds.size.width
let cellWidth:CGFloat = 24
let lineColor:UIColor = UIColor.yellow
class ViewController: UIViewController {
    //    var startDistance:Float = 0;
    var currentScale:CGFloat = 1;
    var lineArray:[CAShapeLayer] = []
    fileprivate  lazy var scroll:UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    var percent:CGFloat = 1
    
    lazy var mainView:UIImageView = {
        let mainView = UIImageView()
        mainView.contentMode = .scaleAspectFit
        return mainView
    }()
    lazy var deleteBtn:UIButton = {
        let deleteBtn = UIButton()
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.backgroundColor = UIColor.blue
        return deleteBtn
    }()
    
    lazy var drawBtn:UIButton = {
        let drawBtn = UIButton()
        drawBtn.setTitle("绘制", for: .normal)
        drawBtn.backgroundColor = UIColor.red
        return drawBtn
    }()
    
    lazy var saveBtn:UIButton = {
        let saveBtn = UIButton()
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.backgroundColor = UIColor.red
        return saveBtn
    }()
    
    //添加颜色画板
    
    //存储绘制颜色的ShapLayer
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加顶部按钮
        
        
        //添加内部显示
        scroll.frame = view.bounds
        if #available(iOS 11.0, *) {
            scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            automaticallyAdjustsScrollViewInsets = false
            // Fallback on earlier versions
        }
        scroll.delegate = self
        view.addSubview(scroll)
        setupData()
        
        //
        
        view.isMultipleTouchEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setupData() {
        if let image = UIImage(named:"background"){
            
            let imageSize = image.size
            mainView.image = image//.cgImage
            let width:CGFloat = imageSize.width
            let height:CGFloat = imageSize.height
            
            mainView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
            var x:CGFloat = 0
            var y:CGFloat = 0
        
            while(x<width){
                x += cellWidth
                let vLine = CAShapeLayer()
                vLine.frame = CGRect(x: x-1, y: 0, width: 2, height: height)
                vLine.backgroundColor = lineColor.withAlphaComponent(0).cgColor
                lineArray.append(vLine)
                mainView.layer.addSublayer(vLine)
            }
            while(y<height){
                y += cellWidth
                let hLine = CAShapeLayer()
                hLine.frame = CGRect(x: 0, y: y-1, width: width, height: 2)
                hLine.backgroundColor = lineColor.withAlphaComponent(0).cgColor
                lineArray.append(hLine)
                mainView.layer.addSublayer(hLine)
            }
            
            if(width/height>WINDOW_WIDTH/WINDOW_HEIGHT){//按照width走
                percent = WINDOW_WIDTH/width
            }else{//按照height走
                percent = WINDOW_HEIGHT/height
            }
            mainView.transform = CGAffineTransform.init(scaleX: percent, y: percent)
            mainView.frame = CGRect(x: (WINDOW_WIDTH-mainView.frame.size.width)/2.0, y: 0,width: mainView.frame.size.width, height: mainView.frame.size.height)
            scroll.contentSize = mainView.frame.size
            scroll.minimumZoomScale = percent  //percent
            scroll.maximumZoomScale = 2
            scroll.addSubview(mainView)
            
        }
        
    }
    
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension ViewController:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print(scrollView.zoomScale)
            for line in lineArray {
                line.backgroundColor = lineColor.withAlphaComponent(scrollView.zoomScale/(2-percent)).cgColor
            }
    }
}
extension ViewController{
    //MARK: touch
    //            mainView.layer.transform = CATransform3DMakeScale(percent, percent, 1);
    //            scroll.layer.addSublayer(mainLayer)
    //    var oneTouch:UITouch?
    //    var twoTouch:UITouch?
    //    lazy var mainLayer:CALayer = {
    //        let mainLayer = CALayer()
    //        mainLayer.contentsGravity = "resizeAspect"
    //        return mainLayer
    //    }()
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        print("touchesBegan\(touches.count)")
    //        if(touches.count>1){
    //            let allobject = touches.sorted(by: { (a, b) -> Bool in
    //                return true
    //            })
    //            oneTouch = allobject.first
    //            twoTouch = allobject.last
    //        }else{
    //            if(oneTouch == nil){
    //                oneTouch = touches.first
    //            }else if(twoTouch == nil){
    //                twoTouch = touches.first
    //            }
    //        }
    //        //        if(oneTouch != nil && twoTouch != nil){
    //        //            let oneCurrentPoint = oneTouch!.location(in: view)
    //        //            let twoCurrentPoint = twoTouch!.location(in: view)
    //        //            startDistance = hypotf(Float(fabs(oneCurrentPoint.x-twoCurrentPoint.x)),Float(fabs(oneCurrentPoint.y-twoCurrentPoint.y)))
    //        //
    //        //        }
    //    }
    //
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        print("touchesMoved\(touches.count)")
    //        if(oneTouch != nil && twoTouch != nil){
    //            let oneCurrentPoint = oneTouch!.location(in: view)
    //            let twoCurrentPoint = twoTouch!.location(in: view)
    //            let currentDistance = hypotf(Float(fabs(oneCurrentPoint.x-twoCurrentPoint.x)),Float(fabs(oneCurrentPoint.y-twoCurrentPoint.y)))
    //
    //            let onePreviousPoint = oneTouch!.previousLocation(in: view)
    //            let twoPreviousPoint = twoTouch!.previousLocation(in: view)
    //            let previousDistance = hypotf(Float(fabs(onePreviousPoint.x-twoPreviousPoint.x)),Float(fabs(onePreviousPoint.y-twoPreviousPoint.y)))
    //            let chargeDistance = currentDistance-previousDistance
    //            //假设最大值1000
    //            let charge = CGFloat(chargeDistance/200.0)
    //
    //            if(currentScale == 1&&charge<0||fabs(charge)<0.01){
    //                return;
    //            }
    //            currentScale += charge
    //            if(currentScale<percent){
    //                currentScale = percent
    //            }
    //            print("charge =\(charge) 1+charge= \(1+charge)-----currentScale =\(currentScale)")
    //            mainView.transform = CGAffineTransform.init(scaleX: percent, y: percent)
    ////            mainLayer.transform = CATransform3DMakeScale(currentScale, currentScale, 1);
    //        }else{
    ////            //拖拽图片
    ////            if let touch = touches.first {
    ////                let point = touch.location(in: view)
    ////                let prePoint = touch.previousLocation(in: view)
    ////                var moveX = point.x-prePoint.x
    ////                var moveY = point.y-prePoint.y
    ////
    ////                let frame = mainLayer.frame
    ////                if(moveX>0&&frame.origin.x>=0){
    ////                    moveX = -frame.origin.x
    ////                }else if(moveX<0&&frame.origin.x+frame.size.width <= view.frame.size.width){
    ////                    moveX = view.frame.size.width-frame.origin.x-frame.size.width
    ////                }
    ////                if(moveY>0&&frame.origin.y>=0){
    ////                    moveY = -frame.origin.y
    ////                }else if(moveY<0&&frame.origin.y+frame.size.height <= view.frame.size.height){
    ////                    moveY = view.frame.size.height-frame.origin.y-frame.size.height
    ////                }
    ////                print("moveX \(moveX) moveY \(moveY) frame \(frame)")
    ////                mainLayer.frame = CGRect(x: frame.origin.x+moveX, y: frame.origin.y+moveY, width: frame.size.width, height: frame.size.height)
    ////            }
    //        }
    //    }
    //
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        if(touches.count>1){
    //            oneTouch = nil
    //            twoTouch = nil
    //        }else{
    //            if(touches.first == oneTouch){
    //                oneTouch = nil
    //            }else if(touches.first == twoTouch){
    //                twoTouch = nil
    //            }
    //        }
    //    }
}
