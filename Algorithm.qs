namespace DeutschJozsa {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;

    operation CheckIfOracleIsBalanced(oracle : ((Qubit, Qubit) == Unit)) : Bool {
        use control = Qubit();
        use target = Qubit();

        H(control);
        X(target);
        H(target);

        oracle(control, target);

        H(target);
        X(target);

        return MResetX(control) == One;
    }

    operation RunDeutschJozsaAlgorithm() : Unit {
        Fact(not CheckIfOracleIsBalanced(ApplyZeroOracle),
            "Test failed for zero oracle.");
        Fact(not CheckIfOracleIsBalanced(ApplyOneOracle),
            "Test failed for one oracle.");
        Fact(CheckIfOracleIsBalanced(ApplyIdOracle),
            "Test failed for id oracle.");
        Fact(CheckIfOracleIsBalanced(ApplyNotOracle),
            "Test failed for not oracle.");

        Message("All tests passed!");
    }
}