//
//  PokedexViewController.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/21/21.
//

import UIKit

class PokedexViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generationsPickerView: UIPickerView!
    let GENERATIONS_LIST = ["Generacion 1","Generacion 2","Generacion 3", "Generacion 4"]
    weak var viewModel = PokedexViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        generationsPickerView.delegate  = self
        generationsPickerView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        viewModel?.getPokemons(id: "1", handler: { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                print("error")
            }
        })
    }
    @IBAction func registerCells() {
        tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "pokeNameCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PokedexDetailViewController {
            guard let cell = sender as? PokedexTableViewCell else {
                return
            }
            vc.idPokemon = cell.number.text ?? ""
        }
    }

}

extension PokedexViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GENERATIONS_LIST[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.getPokemons(id: String(row+1), handler: { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                print("error")
            }
        })
    }
}

extension PokedexViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailPokedex", sender: viewModel?.generation.pokemonSpecies[indexPath.row].url)
    }
}

extension PokedexViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.generation.pokemonSpecies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokeNameCell") as? PokedexTableViewCell else {
            return UITableViewCell()
        }
        guard let pokemon = viewModel?.generation.pokemonSpecies[indexPath.row] else {
            return UITableViewCell()
        }
        cell.name.text = pokemon.name.capitalized
        let number = pokemon.url.components(separatedBy: "-species/")[1].replacingOccurrences(of: "/", with: "")
        cell.number.text = number
        cell.pokeImageView.downloaded(from: API.getPokemonsImagesUrl(game: "platinum", id: number))
        return cell
    }
    
    
}


