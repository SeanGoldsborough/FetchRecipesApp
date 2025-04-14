
import Foundation
struct Recipes : Codable {
	let recipes : [Recipe]?

	enum CodingKeys: String, CodingKey {

		case recipes = "recipes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		recipes = try values.decodeIfPresent([Recipe].self, forKey: .recipes)
	}

}
