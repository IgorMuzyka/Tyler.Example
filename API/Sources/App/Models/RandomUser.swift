
import Vapor

struct RandomUser: Content {

    let name: String
    let surname: String
    let email: String
    let photo: String
    let credit_card: CreditCard

    struct CreditCard: Content {

        let expiration: String
        let number: String
        let pin: Int
        let security: Int
    }
}
