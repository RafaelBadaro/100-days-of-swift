//
//  ContentView.swift
//  cpf-validator
//
//  Created by Rafael Badaró on 07/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cpf: String = ""
    @State private var message: String = ""
    
    @State private var digitosReceitaFederal: String = "-"
    @State private var digitoRegiaoFiscal: String = "-"
    @State private var primeiroDigitoVerificador: String = "-"
    @State private var segundoDigitoVerificador: String = "-"
    
    static private let listaDeNumerosPraSomar = [10, 9, 8, 7, 6, 5, 4, 3, 2]
    
    var body: some View {
        VStack {
            TextField("Digite o cpf", text: $cpf)
                .keyboardType(.numberPad)
                .onChange(of: cpf) {
                    cpf = formatCPF(cpf: cpf)
                }
                .font(.title)
                .textFieldStyle(.roundedBorder)
            
            Text(message)
                .padding()
            
            VStack{
                Text("8 digitos receita federal: \(digitosReceitaFederal)")
                    .padding()
                
                Text("Digito regiao fiscal: \(digitoRegiaoFiscal)")
                    .padding()
                
                Text("Primeiro digito verificador: \(primeiroDigitoVerificador)")
                    .padding()
                
                Text("Segundo digito verificador: \(segundoDigitoVerificador)")
                    .padding()
            }
            .padding()
            
        }
        .padding()
    }
    
    private func formatCPF(cpf: String) -> String{
        // Remove any non-digit characters
        let digits = cpf.filter { $0.isNumber }
        
        // Apply the mask
        let formatted = digits.prefix(11).enumerated().map { index, character -> String in
            switch index {
            case 3, 6:
                return ".\(character)"
            case 9:
                return "-\(character)"
            default:
                return String(character)
            }
        }.joined()
        
        validate(cpf: formatted)
        
        return formatted
    }
    
    private func validate(cpf: String){
        // INFOS:
        //http://clubes.obmep.org.br/blog/a-matematica-nos-documentos-a-matematica-dos-cpfs/
        // CPF tem 11 numeros e 14 digitos (11 numberos + 2 pontos + 1 hifen)
        // ABC.DEF.GHI-JK
        // ABC.DEF.GH -> 8 digitos definidos pela receita federal
        // I -> 9 regiao fiscal emissora do CPF
        // -JK -> 10, 11 Primeiro e segundo digito verificador respectivamente
        
        // Filtra para os digitos serem apenas os numeros
        let digitos = cpf.filter { $0.isNumber }
        
       
        if digitos.count != 11 {
            message = "CPF inválido: faltam números"
            clearFields()
            return
        }
        
        digitosReceitaFederal = String(digitos.prefix(8))
        
        let startDRF = digitos.index(digitos.startIndex, offsetBy: 8)
        let endDRF = digitos.index(digitos.startIndex, offsetBy: 9)
        digitoRegiaoFiscal = String(digitos[startDRF..<endDRF])
        
        let startPDV = digitos.index(digitos.startIndex, offsetBy: 9)
        let endPDV = digitos.index(digitos.startIndex, offsetBy: 10)
        primeiroDigitoVerificador = String(digitos[startPDV..<endPDV])
        
        let startSDV = digitos.index(digitos.startIndex, offsetBy: 10)
        let endSDV = digitos.index(digitos.startIndex, offsetBy: 11)
        segundoDigitoVerificador = String(digitos[startSDV..<endSDV])
        
        validarPrimeiroDigitoVerificador(digitos: digitos,
                                         primeiroDigitoVerificador: primeiroDigitoVerificador)
    }
    
    private func validarPrimeiroDigitoVerificador(digitos: String, primeiroDigitoVerificador: String){
        
        let novePrimeirosDigitos = String(digitos.prefix(9))
        
        var soma: Int = 0
        for i in 0..<9 {
            let index = novePrimeirosDigitos.index(novePrimeirosDigitos.startIndex, offsetBy: i)
            
            let digito = novePrimeirosDigitos[index]
            
            if let digitoInt = digito.wholeNumberValue {
                soma += digitoInt * ContentView.listaDeNumerosPraSomar[i]
            }
        }
        
        let restoDiv = soma % 11
        
        let realPrimeiroDigitoVerificador = String(restoDiv == 0 ? 0 : 11 - restoDiv)
        if primeiroDigitoVerificador != realPrimeiroDigitoVerificador {
            message = "CPF inválido: primeiro dígito verificador inválido. É: \(primeiroDigitoVerificador) e devia ser: \(realPrimeiroDigitoVerificador)"
            return
        }
        
        validarSegundoDigitoVerificador(digitos: digitos,
                                        segundoDigitoVerificador: segundoDigitoVerificador)
    }
    
    private func validarSegundoDigitoVerificador(digitos: String, segundoDigitoVerificador: String){
        let startIndex = digitos.index(digitos.startIndex, offsetBy: 1)
        let endIndex = digitos.index(digitos.startIndex, offsetBy: 9)
        let digitosSegundoAlgarismo = String(digitos[startIndex...endIndex])
        
        var soma: Int = 0
        for i in 0..<9 {
            let index = digitosSegundoAlgarismo.index(digitosSegundoAlgarismo.startIndex, offsetBy: i)
            
            let digito = digitosSegundoAlgarismo[index]
            
            if let digitoInt = digito.wholeNumberValue {
                soma += digitoInt * ContentView.listaDeNumerosPraSomar[i]
            }
        }
        
        let restoDiv = soma % 11
        
        let realSegundoDigitoVerificador = String(restoDiv == 0 ? 0 : 11 - restoDiv)
        if segundoDigitoVerificador != realSegundoDigitoVerificador {
            message = "CPF inválido: segundo dígito verificador inválido. É: \(segundoDigitoVerificador) e devia ser: \(realSegundoDigitoVerificador)"
            return
        }
                
        message = "CPF válido! :)"
    }
    
    private func clearFields(){
        digitosReceitaFederal = "-"
        digitoRegiaoFiscal = "-"
        primeiroDigitoVerificador = "-"
        segundoDigitoVerificador = "-"
    }
    
}

#Preview {
    ContentView()
}
