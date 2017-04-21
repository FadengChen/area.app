//
//  Area.swift
//  tableview
//
//  Created by 陈发登 on 3/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

struct Area {
    var name: String
    var province: String
    var image: String
    var isVisited: Bool
    var rating = ""
    init(name: String, province: String, image: String, isVisited: Bool){
    self.name = name
        self.province = province
        self.image = image
        self.isVisited = isVisited
    }
}


//[Area(name:"185-211 Broadway, Ultimo, Sydney, NSW", province:"current home", image:"t", isVisited:true),
// Area(name:"112A Church Street, Camperdown, Sydney, NSW", province:"used to live", image:"y", isVisited:true),
// Area(name:"广东省佛山区顺德区龙江镇西庆村斯帝丹奴西北侧", province:"guangdong", image:"u", isVisited:true),
// Area(name:"福建省福州市闽侯县闽侯新区福古路北侧昙石路266号", province:"shanghai", image:"i", isVisited:true)]
