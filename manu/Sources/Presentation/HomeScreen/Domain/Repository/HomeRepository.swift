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
    
    func getUserData() async throws -> UserInfo {
        let dto = try await dataSource.getUserData()
        return dto.toDomain()
    }
    
    func getAllLoans() async throws -> [Loans] {
        let dtos = try await dataSource.getAllLoans()
        return dtos.map { $0.toDomain() }
    }
    
    func getAllMonthlyPayment() async throws -> [MonthlyPayment] {
        let dtos = try await dataSource.getAllMonthlyPayments()
        return dtos.map { $0.toDomain() }
    }
    
}
