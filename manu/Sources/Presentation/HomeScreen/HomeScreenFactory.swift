//
//  HomeScreenFactory.swift
//  manu
//
//  Created by Erick Valdez on 4/05/25.
//

struct HomeScreenFactory {
    static func createViewController(coordinator: HomeTabCoordinatorProtocol) -> HomeViewController {
        HomeViewController(viewModel: createViewModel(), coordinator: coordinator)
    }
    
    private static func createViewModel() -> HomeViewModel {
        HomeViewModel(useCase: createUseCase())
    }
    
    private static func createUseCase() -> HomeUseCasesProtocol {
        HomeUseCases(repository: createRepository())
    }
    
    private static func createRepository() -> HomeRepositoryProtocol {
        HomeRepository(dataSource: createDateSource())
    }
    
    private static func createDateSource() -> HomeDataSourceProtocol {
        HomeDataSource()
    }
}
