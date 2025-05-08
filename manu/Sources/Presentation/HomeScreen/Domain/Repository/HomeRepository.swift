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
    
    func getUserData() async -> Result<UserInfoResponseDTO, any Error> {
        return await dataSource.getUserData()
    }
    
    func getAllLoans() async -> Result<[LoansResponseDTO], any Error> {
        return await dataSource.getAllLoans()
    }
    
    func getAllMonthlyPayment() async -> Result<[MonthlyPaymentResponseDTO], any Error> {
        return await dataSource.getAllMonthlyPayment()
    }
}
