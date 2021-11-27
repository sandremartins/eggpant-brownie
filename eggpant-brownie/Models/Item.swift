//
//  Item.swift
//  eggpant-brownie
//
//  Created by Alessandre Martins on 11/27/21.
//

import UIKit

class Item: NSObject {
    
    // MARK: - Atributos
    let nome: String
    let calorias: Double
    
    // MARK: - Init
    
    init (nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}
