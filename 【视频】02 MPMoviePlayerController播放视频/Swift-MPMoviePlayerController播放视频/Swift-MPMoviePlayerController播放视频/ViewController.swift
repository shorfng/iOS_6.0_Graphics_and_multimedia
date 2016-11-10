//
//  ViewController.swift
//  Swift-MPMoviePlayerController播放视频
//
//  Created by 蓝田 on 2016/11/9.
//  Copyright © 2016年 蓝田. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    // 懒加载创建播放器
    lazy var controller: MPMoviePlayerController = {
        
        // ① 本地媒体文件
        let infoPlistPath = Bundle.main.url(forResource: "1", withExtension: "mp4")
        let controller = MPMoviePlayerController(contentURL: infoPlistPath!)
        
        // ② 通过远程URL创, 创建控制器 MPMoviePlayerController
        // let url = URL(string: "http://v1.mukewang.com/3e35cbb0-c8e5-4827-9614-b5a355259010/L.mp4")
        // let controller = MPMoviePlayerController(contentURL: url!)
        
        // 添加播放视图到要显示的视图
        self.view.addSubview((controller?.view)!)
        return controller!
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 3.播放
        controller.play()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // 2. 设置播放视图frame, 添加到需要展示的视图上
        controller.view.frame = view.bounds
    }
}
