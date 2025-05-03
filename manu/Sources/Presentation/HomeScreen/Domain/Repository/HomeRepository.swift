//
//  HomeRepository.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

class HomeRepository: HomeRepositoryProtocol {
    private let dataSource: HomeDataSourceProtocol
    
    init(dataSource: HomeDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getAllMonthlyPayment() async -> Result<[MonthlyPaymentResponseDTO], any Error> {
        return await dataSource.getAllMonthlyPayment()
    }
}
