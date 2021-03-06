//
// Copyright (c) 2020 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

@testable import AdyenCard

final class CardTypeProviderMock: AnyCardTypeProvider {

    var onFetch: ((_ completion: @escaping ([CardType]) -> Void ) -> Void)?

    func requestCardType(for bin: String, supported cardType: [CardType], completion caller: @escaping ([CardType]) -> Void) {
        onFetch?(caller)
    }
}
