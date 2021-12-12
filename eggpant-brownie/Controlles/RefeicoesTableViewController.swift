//
//  RefeicoesTableViewController.swift
//  eggpant-brownie
//
//  Created by Alessandre Martins on 12/11/21.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
    var refeicoes = [Refeicao(nome: "Macarrão", felicidade: 4),
                     Refeicao(nome: "Pizza", felicidade: 5),
                     Refeicao(nome: "Sushi", felicidade: 3)
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
        return celula
    }
    
    func add(_ refeicao: Refeicao) {
        //print("Método add: \(refeicao.nome)")
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    // metodo para passar informações entre viewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // o identifier é para verificar o id do viewController de destino, caso não seja informado, pode dar crash
        if segue.identifier == "adicionar" {
            // o if let é para evitar crash. Verificar uma variavel que vai ser usada nesse bloco if. Em outras ocasioes pode usar guard let no lugar com else e return
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}
