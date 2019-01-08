
import Substitutes

extension Number {

    fileprivate static var random: Number {
        return Number(Double.random(in: 0...1))
    }
}

extension Color {

    public static var random: Color {
        return Color(red: .random, green: .random, blue: .random)
    }
}
