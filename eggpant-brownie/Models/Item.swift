//
//  Item.swift
//  eggpant-brownie
//
//  Created by Alessandre Martins on 11/27/21.
//

import UIKit

class Item: NSObject, NSCoding {
    
    // MARK: - Atributos
    let nome: String
    let calorias: Double
    
    // MARK: - Init
    
    init (nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
    
    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(calorias, forKey: "calorias")
    }
    
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        calorias = coder.decodeDouble(forKey: "calorias")
    }
}
