namespace DeutschJozsa {
    open Microsoft.Quantum.Intrinsic;

    operation ApplyZeroOracle(control: Qubit, target: Qubit) : Unit {

    }

    operation ApplyOneOracle(control: Qubit, target: Qubit) : Unit {
        X(target);
    }

    operation ApplyIdOracle(control: Qubit, target: Qubit): Unit {
        CNOT(control, target);
    }

    operation ApplyNotOracle(control: Qubit, target: Qubit): Unit {
        X(control);
        CNOT(control, target);
        X(control);
    }
}