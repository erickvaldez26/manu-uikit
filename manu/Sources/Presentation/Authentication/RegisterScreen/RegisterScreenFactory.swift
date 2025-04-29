//
//  RegisterScreenFactory.swift
//  manu
//
//  Created by Erick Valdez on 28/04/25.
//

struct RegisterScreenFactory {
    static func createViewController(coordinator: AuthenticationCoordinator) -> AuthRegisterViewController {
        AuthRegisterViewController(viewModel: createViewModel(), coordinator: coordinator)
    }
    
    private static func createViewModel() -> AuthRegisterViewModel {
        AuthRegisterViewModel(useCase: createUseCase())
    }
    
    private static func createUseCase() -> RegisterUseCasesImpl {
        RegisterUseCasesImpl(repository: createRepository())
    }
    
    private static func createRepository() -> RegisterRepositoryImpl {
        RegisterRepositoryImpl(dataSource: createDateSource())
    }
    
    private static func createDateSource() -> RegisterDataSourceImpl {
        RegisterDataSourceImpl()
    }
}
