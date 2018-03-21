import FluentProvider
import LeafProvider
import AuthProvider

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [Row.self, JSON.self, Node.self]

        try setupProviders()
        try setupPreparations()
        setupGlobalMiddleWare()
    }
    
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(FluentProvider.Provider.self)
        try addProvider(LeafProvider.Provider.self)
    }
    
    /// Add all models that should have their
    /// schemas prepared before the app boots
    private func setupPreparations() throws {
        //preparations.append(Skill.self)
    }
    
    private func setupGlobalMiddleWare() {
        self.addConfigurable(log: AllCapsLogger.init, name: "all-caps")
    }
}
