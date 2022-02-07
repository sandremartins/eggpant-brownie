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
                     Refeicao(nome: "Sushi", felicidade: 3)]
    
    override func viewDidLoad() {
        guard let caminho = recuperaCaminho() else { return }
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else { return }
            refeicoes = refeicoesSalvas
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperaCaminho() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let caminho = diretorio.appendingPathComponent("refeicao")
        
        return caminho
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    func add(_ refeicao: Refeicao) {
        //print("Método add: \(refeicao.nome)")
        refeicoes.append(refeicao)
        tableView.reloadData()
        
        guard let caminho = recuperaCaminho() else { return }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            // print("longPress gesture")
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else {return}
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: { alert in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
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
