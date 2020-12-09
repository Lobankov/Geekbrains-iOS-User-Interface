//
//  GroupFactory.swift
//  GeekbrainsVK
//
//  Created by Alexey Lobankov on 10.12.2020.
//

import Foundation

enum GroupFactory {
    
    static func makeDummyGroups() -> [GroupModel] {
        
        let rip = GroupModel(name: "Рифмы и Панчи", imagePath: "rip")
        let design = GroupModel(name: "Десигн", imagePath: "design")
        let redit = GroupModel(name: "Redit", imagePath: "redit")
        let pikabu = GroupModel(name: "Пикабу", imagePath: "pikabu")
        let lentach = GroupModel(name: "Лентач", imagePath: "lentach")
        let habr = GroupModel(name: "Хабр", imagePath: "habr")
        let pesi = GroupModel(name: "Песы", imagePath: "pesi")
        let wow = GroupModel(name: "World of Warcraft", imagePath: "wow")
        let mrzlk = GroupModel(name: "MRZLK", imagePath: "mrzlk")
        let maddyson = GroupModel(name: "Maddyson", imagePath: "maddyson")
        let kinopoisk = GroupModel(name: "Кинопоиск", imagePath: "kinopoisk")
        let duran = GroupModel(name: "Duran", imagePath: "duran")
        let og = GroupModel(name: "Optimus Gang", imagePath: "og")
        let lumen = GroupModel(name: "Lumen", imagePath: "lumen")
        let swift = GroupModel(name: "Swift Book", imagePath: "swift")
        let eltsin = GroupModel(name: "Фан клуб Ельцина", imagePath: "eltsin")
        
        return [rip, design, redit, pikabu, lentach, habr, pesi, wow, mrzlk, maddyson, kinopoisk, duran, og, lumen, swift, eltsin]
    }
    
}
