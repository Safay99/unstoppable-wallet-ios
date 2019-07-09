class RestorePresenter {
    weak var view: IRestoreView?
    weak var restoreDelegate: IRestoreDelegate?

    private let router: IRestoreRouter
    private let accountCreator: IAccountCreator

    private var types = [PredefinedAccountType]()

    init(router: IRestoreRouter, accountCreator: IAccountCreator, delegate: IRestoreDelegate? = nil) {
        self.router = router
        self.accountCreator = accountCreator
        self.restoreDelegate = delegate
    }

}

extension RestorePresenter: IRestoreViewDelegate {

    func viewDidLoad() {
        types = PredefinedAccountType.allCases
    }

    var typesCount: Int {
        return types.count
    }

    func type(index: Int) -> PredefinedAccountType {
        return types[index]
    }

    func didSelect(index: Int) {
        router.showRestore(type: types[index], delegate: self)
    }

    func didTapCancel() {
        router.close()
    }

}

extension RestorePresenter: IRestoreDelegate {

    func didRestore(accountType: AccountType, syncMode: SyncMode?) {
        _ = accountCreator.createRestoredAccount(accountType: accountType, syncMode: syncMode)

        restoreDelegate?.didRestore(accountType: accountType, syncMode: syncMode)
        router.close()
    }

}
