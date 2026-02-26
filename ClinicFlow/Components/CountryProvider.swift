import Foundation

struct CountryProvider {
    
    static func loadCountries() -> [Country] {
        
        let locale = Locale.current
        
        return Locale.Region.isoRegions.compactMap { region in
            
            guard
                let name = locale.localizedString(forRegionCode: region.identifier),
                let dial = DialCodeProvider.codes[region.identifier]
            else {
                return nil
            }
            
            return Country(
                name: name,
                isoCode: region.identifier,
                dialCode: dial
            )
        }
        .sorted { $0.name < $1.name }
    }
}

